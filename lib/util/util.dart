import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/sp.dart';
import 'package:ifafu/util/toast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static void joinQQGroup({required int groupId}) async {
    final url = Uri.parse('mqqapi://card/show_pslcard?src_type=internal'
        '&version=1&uin=$groupId&card_type=group&source=qrcode');
    if (!await launchUrl(url)) {
      ToastUtil.show('未安装QQ');
    }
  }

  static void checkUpdate(
    BuildContext context, {
    bool silent = false,
  }) async {
    var channel = SPUtil.getString("UPDATE_CHANNEL") ?? 'stable';
    String platform;
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    } else {
      return;
    }
    AppUpdate latest;
    try {
      latest = await Api.instance.checkUpdate(
        channel: channel,
        platform: platform,
      );
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      if (!silent) {
        ToastUtil.error(e, '检查更新失败');
      }
      return;
    }
    var packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      if (int.parse(packageInfo.buildNumber) >= latest.code) {
        if (!silent) {
          ToastUtil.show('当前已是最新版本');
        }
        return;
      }
      if (!latest.force && latest.noticeTime > 0 && silent) {
        var lastUpdateId = SPUtil.getInt('LAST_UPDATE_ID');
        if (lastUpdateId == latest.id) {
          var lastNoticeTime = SPUtil.getInt('LAST_NOTICE_TIME') ?? 0;
          if (lastNoticeTime >= latest.noticeTime) {
            return;
          }
        } else {
          SPUtil.setInt('LAST_UPDATE_ID', latest.id);
        }
        var noticeTime = SPUtil.getInt('LAST_NOTICE_TIME') ?? 0;
        SPUtil.setInt('LAST_NOTICE_TIME', noticeTime + 1);
      }
      if (int.parse(packageInfo.buildNumber) >= latest.code) {
        if (!silent) {
          ToastUtil.show('当前已是最新版本');
        }
        return;
      }

      if (!context.mounted) return;
      _showUpdateDialog(context, latest, packageInfo);
    }
  }

  static Future<bool> _showUpdateDialog(
    BuildContext context,
    AppUpdate update,
    PackageInfo packageInfo,
  ) async {
    bool? result = await showAdaptiveDialog(
      context: context,
      barrierDismissible: !update.force,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '发现新版本，是否立即更新？',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('''
当前版本: ${packageInfo.version}+${packageInfo.buildNumber}
最新版本: ${update.version}+${update.code}
更新内容：
${update.description}'''),
          actions: [
            if (!update.force)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  '暂不更新',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                _startUpgrade(context, update);
              },
              child: const Text('立即更新'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  static _startUpgrade(
    BuildContext context,
    AppUpdate update,
  ) async {
    ToastUtil.show('开始下载APK...');
    final dir = await getApplicationDocumentsDirectory();
    final savePath = '${dir.path}/app_${update.version}+${update.code}.apk';

    if (!context.mounted) return;
    final result = await _showDownloadDialog(context, update, savePath);
    File file = File(savePath);
    if (result) {
      if (Platform.isAndroid) {
        final uri = file.uri;
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          ToastUtil.show('安装包不存在');
        }
      }
    }
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  static _showDownloadDialog(
    BuildContext context,
    AppUpdate update,
    String savePath,
  ) async {
    final result = await showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final key = GlobalKey<_DownloadProgressState>();
        return AlertDialog(
          key: key,
          title: const Text('正在下载更新'),
          content: DownloadProgress(
            url: update.url,
            savePath: savePath,
            onSuccess: () => Navigator.of(context).pop(true),
          ),
          actions: [
            TextButton(
              onPressed: () {
                key.currentState?.cancel();
                ToastUtil.show('已取消下载');
              },
              child: const Text('取消'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}

class DownloadProgress extends StatefulWidget {
  const DownloadProgress({
    Key? key,
    required this.url,
    required this.savePath,
    required this.onSuccess,
  }) : super(key: key);

  final String url;
  final String savePath;
  final void Function() onSuccess;

  @override
  createState() => _DownloadProgressState();
}

class _DownloadProgressState extends State<DownloadProgress> {
  late final Dio _dio;
  late final CancelToken _cancelToken;
  late final StreamController<double> _progressController;

  @override
  void initState() {
    super.initState();
    _dio = Api.dio;
    _cancelToken = CancelToken();
    _progressController = StreamController<double>();
    _downloadFile();
  }

  @override
  void dispose() {
    _progressController.close();
    _cancelToken.cancel();
    super.dispose();
  }

  Future<void> _downloadFile() async {
    try {
      final response = await _dio.download(
        widget.url,
        widget.savePath,
        cancelToken: _cancelToken,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            final progress = receivedBytes / totalBytes;
            _progressController.add(progress);
          }
        },
      );
      widget.onSuccess();
      if (kDebugMode) {
        print('Download complete: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during download: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _progressController.stream,
      builder: (context, snapshot) {
        final progress = snapshot.data ?? 0;
        return LinearProgressIndicator(value: progress);
      },
    );
  }

  void cancel() {
    _cancelToken.cancel();
  }
}
