import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/date.dart';
import 'package:ifafu/util/extensions.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/post.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late model.Post _post;
  late model.User? _user;

  final commentController = TextEditingController();
  var lastComment = '';
  final commentFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _user = BlocProvider.of<UserProvider>(context).state;
    commentFocus.addListener(() {
      if (commentFocus.hasFocus) {
        commentController.text = lastComment;
      } else {
        lastComment = commentController.text;
        commentController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _post = arguments['post'] as model.Post;

    return GestureDetector(
      onTap: () {
        commentFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('帖子详情'),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            Expanded(child: Scrollable(
              viewportBuilder: (context, position) {
                return Column(
                  children: [
                    Post(
                      post: _post,
                      currentUser: _user,
                      detailMode: true,
                      deleted: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    if (_post.comments != null &&
                        _post.comments!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        width: double.infinity,
                        color: Colors.white,
                        child: const Text(
                          '评论',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1),
                      ..._buildComments(_post.comments!)
                    ]
                  ],
                );
              },
            )),
            //评论输入框
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 若用户不存在则头像框中显示未登录
                  _user == null
                      ? const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/image/defaultAvatar.png'),
                          child: Text('未登录'),
                        )
                      : _getAvatar(_user?.avatarUrl, size: 20),
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
                        focusNode: commentFocus,
                        controller: commentController,
                        // expands: true,
                        minLines: null,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                          hintText: '说点什么吧...',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FilledButton.tonal(
                    onPressed: comment,
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(64, 40))),
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Iterable<Container> _buildComments(List<model.Comment> comments) {
    return comments.map((comment) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 4.0),
            _getAvatar(comment.createBy.avatarUrl, size: 20),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.createBy.nickname,
                        strutStyle: const StrutStyle(
                          forceStrutHeight: true,
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    comment.content,
                    strutStyle: const StrutStyle(
                      forceStrutHeight: true,
                    ),
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        formatTime(comment.createTime),
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                      //删除按钮
                      if ((_user != null && (_user!.id == _post.createBy.id) ||
                          _user!.hasPermission('post:del')))
                        GestureDetector(
                          onTap: () {
                            _showCommentDeleteDialog(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Text(
                              '删除',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF4A90E2),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
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

  void comment() {
    final comment = commentController.text.trim();
    if (comment.isEmpty) {
      ToastUtil.show('评论不能为空');
      return;
    }
    Api.instance.commentPost(_post.id, comment).then((value) {
      ToastUtil.show('评论成功');
      _post = value;
      setState(() {});
    }).catchError((err) {
      if (err is DioException && err.message != null) {
        ToastUtil.show(err.message!);
      } else {
        ToastUtil.show('评论失败');
      }
    });
  }

  void _showCommentDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除评论'),
          content: const Text('确定要删除这条评论吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                deleteComment(_post.id);
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void deleteComment(int id) {
    Api.instance.deleteComment(id).then((value) {
      ToastUtil.show('删除成功');
      _post.comments!.removeWhere((element) => element.id == id);
      setState(() {});
    }).catchError((err) {
      if (err is DioException && err.message != null) {
        ToastUtil.show(err.message!);
      } else {
        ToastUtil.show('删除失败');
      }
    });
  }
}
