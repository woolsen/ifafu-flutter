import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/page/image_viewer.dart';
import 'package:ifafu/page/qa_library_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/widget/bottom_input_bar.dart';
import 'package:ifafu/widget/router.dart';

class QaPage extends StatefulWidget {
  const QaPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QaPageState();
}

class _QaPageState extends State<QaPage> {
  final _focusNode = FocusNode();

  final _records = <_Record>[];

  late ScrollController _scrollController;

  String? _userAvatarUrl;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _userAvatarUrl = context.read<UserProvider>().state?.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    if (_records.isEmpty) {
      _addMessage(
        Sender.bot,
        [
          Message(type: 'text', data: {'text': '你好，我是你的专属词条机器人~\n发送关键词查询词条~'}),
          Message(
            type: 'clickable',
            data: {
              'text': '点击查看【常用词条】',
              'click': () {
                _sendMessage('常用词条');
              }
            },
          ),
          Message(
            type: 'clickable',
            data: {
              'text': '点击查看【全部词条】',
              'click': () async {
                String? question = await Navigator.of(context).push<String?>(
                  SlideRightRoute(page: const QaLibraryPage()),
                );
                if (question != null) {
                  _sendMessage(question);
                }
              },
            },
          ),
        ],
      );
    }
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('词条问答'),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                reverse: true,
                initialItemCount: _records.length,
                // shrinkWrap: true,
                itemBuilder: (context, index, animation) {
                  var record = _records[index];
                  var child = _buildMessage(record);
                  child = FadeTransition(
                    opacity:
                        Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                    child: child,
                  );
                  child = SlideTransition(
                    position: Tween<Offset>(
                      begin: record.sender == Sender.bot
                          ? const Offset(-0.1, 1.0)
                          : const Offset(0.1, 1.0),
                      end: const Offset(0, 0),
                    ).animate(animation),
                    child: child,
                  );
                  child = ScaleTransition(
                    scale: animation,
                    alignment: record.sender == Sender.bot
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    child: child,
                  );
                  return child;
                },
              ),
            ),
            BottomInputBar(
              focusNode: _focusNode,
              oneLine: true,
              textInputAction: TextInputAction.send,
              sendAsync: _sendMessage,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMessage(_Record record) {
    final ImageProvider avatar;
    if (record.sender == Sender.bot) {
      avatar = const AssetImage('assets/image/bot.jpg');
    } else if (_userAvatarUrl != null) {
      avatar = CachedNetworkImageProvider(_userAvatarUrl!);
    } else {
      avatar = const AssetImage('assets/image/defaultAvatar.png');
    }
    final Widget avatarWidget = CircleAvatar(
      backgroundImage: avatar,
      radius: 20,
    );
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (record.sender == Sender.bot) ...[
            avatarWidget,
            const SizedBox(width: 8),
          ] else
            const Spacer(),
          IntrinsicWidth(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: 40,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: record.sender == Sender.bot
                    ? Colors.white
                    : const Color(0xFFE1F5FE),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: MessageView(
                record.message,
                onClick: (message) {
                  if (message.type == 'send_message') {
                    _sendMessage(message.data['message'].toString());
                  }
                },
              ),
            ),
          ),
          if (record.sender == Sender.me) ...[
            const SizedBox(width: 8),
            avatarWidget,
          ],
        ],
      ),
    );
  }

  Future<bool> _sendMessage(String text) async {
    await _addMessage(
      Sender.me,
      [
        Message(type: 'text', data: {'text': text})
      ],
    );
    try {
      var res = await Api.instance.queryQaAnswer(text);
      await _addMessage(Sender.bot, res);
    } catch (e) {
      if (e is DioException && e.response?.data['code'] == 404) {
        await _addMessage(
          Sender.bot,
          [
            Message(type: 'text', data: {'text': '未找到答案'}),
            Message(
              type: 'clickable',
              data: {
                'text': '点击查看【常用词条】',
                'click': () {
                  _sendMessage('常用词条');
                }
              },
            ),
          ],
        );
      } else {
        await _addMessage(
          Sender.bot,
          [
            Message(type: 'text', data: {'text': '出错了，你可以稍后再试试\n$e'})
          ],
        );
      }
    }
    return true;
  }

  Future<void> _addMessage(
    Sender sender,
    List<Message> message,
  ) async {
    _records.insert(
      0,
      _Record(sender, _mapMessage(message)),
    );
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 200),
    );
    if (_scrollController.positions.isNotEmpty) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  List<Message> _mapMessage(List<Message> message) {
    if (message.length <= 1) {
      return message;
    }
    final List<Message> mergedMessage = [];
    for (var i = 1; i < message.length; i++) {
      final pre = message[i - 1];
      final cur = message[i];
      if (pre.type == 'text' && cur.type == 'image') {
        mergedMessage.add(Message(
          type: 'text',
          data: {
            'text': (pre.data['text'] as String).trimRight(),
          },
        ));
      } else {
        mergedMessage.add(pre);
      }
    }
    mergedMessage.add(message.last);
    return mergedMessage;
  }
}

enum Sender { bot, me }

class _Record {
  final Sender sender;
  final List<Message> message;

  _Record(this.sender, this.message);
}

class MessageView extends StatelessWidget {
  final List<Message> message;

  final TextStyle textStyle;
  final void Function(Message) onClick;

  static const messageTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );

  const MessageView(
    this.message, {
    super.key,
    required this.onClick,
    this.textStyle = messageTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: message.map((e) {
        Widget child;
        switch (e.type) {
          case 'text':
            child = SelectableText(
              e.data['text'].toString(),
              style: messageTextStyle,
            );
          case 'image':
            child = _buildImage(context, e.data['file']);
          case 'clickable':
            child = GestureDetector(
              onTap: () {
                Function? click = e.data['click'];
                click?.call();
              },
              child: Text(
                e.data['text'].toString(),
                style: messageTextStyle.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          case 'widget':
            child = e.data['widget'] as Widget;
          default:
            child = const SizedBox();
        }
        return child;
      }).toList(),
    );
  }

  Widget _buildImage(BuildContext context, String url) {
    DateTime dateTime = DateTime.now();
    return GestureDetector(
      onTap: () => _goToImageViewer(context, url, dateTime),
      child: Hero(
        tag: dateTime,
        createRectTween: (begin, end) {
          return RectTween(begin: begin, end: end);
        },
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  _goToImageViewer(BuildContext context, String url, Object heroTag) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, __) {
          return ImageViewer(
            currentIndex: 0,
            items: [ImageItem(imageUrl: url, tag: heroTag)],
          );
        },
      ),
    );
  }
}
