import 'package:flutter/material.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/toast.dart';

class CommentInput extends StatefulWidget {
  final int postId;
  final void Function(Post) onCommented;
  final User? user;

  const CommentInput({
    super.key,
    required this.postId,
    required this.onCommented,
    this.user,
  });

  @override
  State<StatefulWidget> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _controller = TextEditingController();
  var _lastComment = '';
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.text = _lastComment;
      } else {
        _lastComment = _controller.text;
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: data.viewInsets.bottom + data.padding.bottom + 8,
        left: 8,
        right: 8,
      ),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 若用户不存在则头像框中显示未登录
          if (widget.user != null) _getAvatar(widget.user!.avatarUrl, size: 20),
          const SizedBox(width: 4.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              constraints: const BoxConstraints(
                minHeight: 40.0,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Theme.of(context).splashColor,
                ),
              ),
              // color: Theme.of(context).splashColor,
              child: TextField(
                focusNode: _focusNode,
                controller: _controller,
                minLines: null,
                maxLines: null,
                decoration: const InputDecoration.collapsed(
                  hintText: '说点什么吧...',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ).copyWith(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          IconButton.filledTonal(
            onPressed: comment,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void comment() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ToastUtil.show('评论不能为空');
      return;
    }
    Api.instance.commentPost(widget.postId, text).then((post) {
      widget.onCommented(post);
      _controller.clear();
      _focusNode.unfocus();
    });
  }

  Widget _getAvatar(String? avatarUrl, {double size = 22}) {
    if (avatarUrl == null) {
      return CircleAvatar(
        radius: size,
        backgroundImage: const AssetImage('assets/image/defaultAvatar.png'),
      );
    }
    return CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(avatarUrl.startsWith('/')
            ? 'https://api2.ifafu.cn$avatarUrl'
            : avatarUrl));
  }
}
