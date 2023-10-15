import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/page/bind_jw_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/util.dart';

typedef Logout = void Function();

class UserTab extends StatefulWidget {
  final Logout logouted;

  const UserTab({
    Key? key,
    required this.logouted,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProvider, model.User?>(
      bloc: BlocProvider.of<UserProvider>(context),
      builder: (context, user) {
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile/edit');
                    },
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
                              user.nickname,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '发福号: ${user.id}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                if (!user.isBindJw) ...[
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('绑定教务系统'),
                    onTap: _goToBindJwPage,
                  ),
                ],
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('我的帖子'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/post/my');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('反馈与建议'),
                  onTap: _goToFeedback,
                ),
                if (user.isBindJw) ...[
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('解绑教务系统'),
                    onTap: _showUnbindJwDialog,
                  ),
                ],
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('关于iFAFU'),
                  onTap: () => Navigator.of(context).pushNamed('/about'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('退出登录'),
                  onTap: _showLogoutDialog,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _goToFeedback() {
    Util.joinQQGroup(groupId: 964416588);
  }

  void _showUnbindJwDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('解绑教务系统'),
          content: const Text('确定要解绑教务系统吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                await Api.instance.unbindJw();
                final userProvider = context.read<UserProvider>();
                final user = userProvider.state?.copyWith(isBindJw: false);
                userProvider.update(user);
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _goToBindJwPage() async {
    bool? result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => const BindJwPage(),
      ),
    );
    if (result == true) {
      final userProvider = context.read<UserProvider>();
      final user = userProvider.state?.copyWith(isBindJw: true);
      userProvider.update(user);
    }
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
                widget.logouted();
                context.read<UserProvider>().logout();
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
