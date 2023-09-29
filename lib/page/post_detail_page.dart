import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/date.dart';
import 'package:ifafu/widget/post.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late model.Post _post;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _post = arguments['post'] as model.Post;

    model.User? user = context.read<UserProvider>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子详情'),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(child: Scrollable(
            viewportBuilder: (BuildContext context, ViewportOffset position) {
              return Column(
                children: [
                  Post(
                    post: _post,
                    detailMode: true,
                  ),
                  if (_post.comments != null && _post.comments!.isNotEmpty) ...[
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
                user == null
                    ? const CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/image/defaultAvatar.png'),
                        child: Text('未登录'),
                      )
                    : _getAvatar(user.avatarUrl, size: 20),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    // color: Theme.of(context).splashColor,
                    child: const TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: '评论',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                FilledButton.tonal(
                  onPressed: () {},
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(64, 40))),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
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
                  Text(
                    formatTime(comment.createTime),
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
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
}
