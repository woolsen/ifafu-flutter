import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于iFAFU'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Image.asset(
            'assets/image/logo.png',
            height: 80,
          ),
          const SizedBox(height: 8),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'v${snapshot.data?.version}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DingTalk'),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: 300,
            child: Text(
              'iFAFU是一款面向福建农林大学的校园生活APP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          ListTile(
            title: const Text('检查更新'),
            leading: const Icon(Icons.update),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('商业合作'),
            leading: const Icon(Icons.business),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              launchUrlString('mqqwpa://im/chat?chat_type=wpa&uin=2928093936');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('iFAFU官网'),
            leading: const Icon(Icons.web),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              launchUrlString('https://ifafu.cn');
            },
          ),
          const SizedBox(height: 16),
          const Spacer(),
          const Text(
            'Copyright©2018-2023 Fafu Technology Co., Ltd.',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
