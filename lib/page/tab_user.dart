import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/setting');
                },
                icon: const Icon(Icons.settings_rounded),
              )
            ],
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

}
