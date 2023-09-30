import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart' as model;

typedef Logout = void Function();

class UserTab extends StatefulWidget {
  final model.User? user;

  final Logout logout;

  const UserTab({
    Key? key,
    required this.user,
    required this.logout,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('登录'),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 64,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user!.nickname,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '发福号: ${widget.user!.id}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile/edit');
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.5, height: 4),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('我的帖子'),
              onTap: () {
                Navigator.of(context).pushNamed('/post/my');
              },
            ),
            const Divider(thickness: 0.5, height: 4),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('退出登录'),
              onTap: _showLogoutDialog,
            ),
          ],
        ),
      ),
    );
  }

  _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('退出登录'),
          content: const Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                widget.logout();
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}
