import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/provider/user_provider.dart';

import 'main_tabs.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {

  User? _user;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _user = context.read<UserProvider>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<UserProvider, User?>(
          listener: (context, state) {
            setState(() {
              _user = state;
            });
          },
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const MainTab(),
            const TimetableTab(),
            UserTab(
              user: _user,
              logout: () {
                context.read<UserProvider>().logout();
                _currentIndex = 0;
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: '课程表',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: _user == null ? '登录' : '我的',
            ),
          ],
          onTap: _handleTabChange,
        ),
      ),
    );
  }

  void _handleTabChange(int index) {
    // 在这里执行你的自定义逻辑，例如拦截Tab切换
    if (index == 2 && _user == null) {
      Navigator.of(context).pushNamed('/login');
    } else {
      // 允许切换到其他选项卡
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
