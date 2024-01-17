import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/page/bind_jw_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/util.dart';

import '../http/api.dart';

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
        return Scaffold(
          backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pushNamed('/setting');
            //     },
            //     icon: const Icon(Icons.settings_rounded),
            //   )
            // ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (user != null) {
                        Navigator.of(context).pushNamed('/profile/edit');
                      } else {
                        Navigator.of(context).pushNamed('/login');
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: user != null
                              ? NetworkImage(user.avatarUrl)
                              : const AssetImage(
                                      'assets/image/defaultAvatar.png')
                                  as ImageProvider<Object>,
                        ),
                        const SizedBox(width: 12),
                        if (user != null)
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
                          )
                        else
                          const Text(
                            '点击登录',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                if (user != null)
                  Card(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          _buildListTitle(
                            icon: const Icon(Icons.favorite),
                            text: '我的帖子',
                            onTap: () {
                              Navigator.of(context).pushNamed('/post/my');
                            },
                          ),
                          _buildListTitle(
                            icon: const Icon(Icons.school),
                            text: user.isBindJw ? '解绑教务系统' : '绑定教务系统',
                            onTap: () {
                              if (user.isBindJw) {
                                _showUnbindJwDialog();
                              } else {
                                _goToBindJwPage();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        _buildListTitle(
                          icon: const Icon(Icons.feedback),
                          text: '意见反馈',
                          onTap: _goToFeedback,
                        ),
                        _buildListTitle(
                          icon: const Icon(Icons.security_update_rounded),
                          text: '检查更新',
                          onTap: () {
                            Util.checkUpdate(context);
                          },
                        ),
                        _buildListTitle(
                          icon: const Icon(Icons.info),
                          text: '关于iFAFU',
                          onTap: () =>
                              Navigator.of(context).pushNamed('/about'),
                        ),
                        _buildListTitle(
                          show: user != null,
                          icon: const Icon(Icons.logout),
                          text: '退出登录',
                          onTap: _showLogoutDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListTitle({
    required Icon icon,
    required String text,
    required void Function() onTap,
    bool? show,
  }) {
    if (show == false) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(width: 24),
            icon,
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 24),
            const Icon(Icons.chevron_right),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  void _goToFeedback() {
    Util.joinQQGroup(groupId: 964416588);
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
