import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String? title;
  final bool hideAppBar;

  const WebViewPage({
    super.key,
    required this.url,
    this.title,
    this.hideAppBar = false,
  });

  @override
  createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _controller;

  final title = ValueNotifier<String?>(null);
  final progress = ValueNotifier<int?>(null);

  final canGoBack = ValueNotifier<bool>(false);
  final canGoForward = ValueNotifier<bool>(false);

  var forcePop = false;

  @override
  Widget build(BuildContext context) {
    _controller ??= initController();
    return WillPopScope(
      onWillPop: () async {
        if (!forcePop && await _controller!.canGoBack()) {
          _controller!.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: widget.hideAppBar
            ? null
            : AppBar(
                leading: IconButton(
                  onPressed: () {
                    forcePop = true;
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse(widget.url));
                    },
                    icon: const Icon(Icons.open_in_new),
                  ),
                ],
                title: widget.title != null
                    ? Text(widget.title!)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('网页浏览'),
                          ValueListenableBuilder<String?>(
                            valueListenable: title,
                            builder: (context, value, child) {
                              return value == null || value.isEmpty
                                  ? const SizedBox.shrink()
                                  : Text(
                                      value,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
              ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<int?>(
                valueListenable: progress,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value != null && value != 100 ? value / 100 : null,
                    minHeight: 2,
                  );
                },
              ),
            ),
            Positioned.fill(child: WebViewWidget(controller: _controller!)),
          ],
        ),
      ),
    );
  }

  WebViewController initController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    return controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            this.progress.value = progress;
          },
          onPageStarted: (String url) {
            title.value = null;
          },
          onPageFinished: (String url) {
            loadTitle(int retry) {
              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                controller
                    .runJavaScriptReturningResult('document.title')
                    .then((value) {
                  String title = value.toString();
                  title = title.substring(1, title.length - 1);
                  if (title.isNotEmpty) {
                    this.title.value = title;
                  } else {
                    if (retry > 0) {
                      loadTitle(retry - 1);
                    }
                  }
                });
              });
            }

            loadTitle(10);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _controller?.loadRequest(Uri.parse('about:blank'));
    super.dispose();
  }
}
