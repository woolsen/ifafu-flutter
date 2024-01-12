import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/util.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserProvider, User?>(
          bloc: BlocProvider.of<UserProvider>(context),
          builder: (context, user) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                if (user?.isBindJw == true) ...[
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('解绑教务系统'),
                    onTap: _showUnbindJwDialog,
                  ),
                ],
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('关于iFAFU'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).pushNamed('/about'),
                ),
                ListTile(
                  title: const Text('商业合作'),
                  leading: const Icon(Icons.business),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    launchUrlString('mqqwpa://im/chat?chat_type=wpa&uin=27907670');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security_update_rounded),
                  title: const Text('检查更新'),
                  onTap: () {
                    Util.checkUpdate(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('退出登录'),
                  onTap: _showLogoutDialog,
                ),
                FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final packageInfo = snapshot.data as PackageInfo;
                      return Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                              '当前版本V${packageInfo.version}+${packageInfo.buildNumber}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
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
