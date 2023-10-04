import 'package:flutter/material.dart';

class BottomInputBar extends StatefulWidget {
  final bool Function(String)? send;
  final Future<bool> Function(String)? sendAsync;
  final FocusNode? focusNode;
  final String? avatarUrl;
  final bool oneLine;
  final TextInputAction? textInputAction;

  const BottomInputBar({
    super.key,
    this.send,
    this.sendAsync,
    this.oneLine = false,
    this.avatarUrl,
    this.focusNode,
    this.textInputAction,
  }) : assert(send != null || sendAsync != null);

  @override
  State<StatefulWidget> createState() => _BottomInputBarState();
}

class _BottomInputBarState extends State<BottomInputBar> {
  final _controller = TextEditingController();
  var _lastText = '';

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    if (!widget.oneLine) {
      _effectiveFocusNode.addListener(() {
        if (_effectiveFocusNode.hasFocus) {
          _controller.text = _lastText;
        } else {
          _lastText = _controller.text;
          _controller.clear();
        }
      });
    }
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
          if (widget.avatarUrl != null)
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.avatarUrl!),
            ),
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
                focusNode: _effectiveFocusNode,
                controller: _controller,
                minLines: widget.oneLine ? 1 : null,
                maxLines: widget.oneLine ? 1 : null,
                textInputAction: widget.textInputAction,
                onSubmitted: doSend,
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
            onPressed: () {
              doSend(_controller.text);
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void doSend(String text) {
    if (text.isEmpty) {
      // ToastUtil.show('消息不能为空');
      return;
    }
    if (widget.send != null) {
      if (widget.send!(text)) {
        _controller.clear();
      }
    } else if (widget.sendAsync != null) {
      widget.sendAsync!(text).then((res) {
        if (res) {
          _controller.clear();
        }
      });
    }
  }
}
