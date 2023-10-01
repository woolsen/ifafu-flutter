import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/page/tab_main.dart';
import 'package:ifafu/page/tab_timetable.dart';
import 'package:ifafu/page/tab_user.dart';
import 'package:ifafu/provider/user_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int _currentIndex = 0;

  var lastFetchUserInfoTime = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    // 注册WidgetsBindingObserver以监听应用程序生命周期状态
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // 移除WidgetsBindingObserver以避免内存泄漏
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 应用程序生命周期状态变化时调用
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _fetchUserInfo();
    }
  }

  void _fetchUserInfo() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - lastFetchUserInfoTime < 60000) {
      return;
    }
    lastFetchUserInfoTime = currentTime;
    Api.instance.getUserInfo().then((user) {
      context.read<UserProvider>().update(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 透明状态栏背景
        statusBarIconBrightness: Brightness.dark, // 设置状态栏文字颜色为黑色
      ),
    );
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const MainTab(), // const TimetableTab(),
          const TimetableTab(
            key: Key('timetable'),
          ),
          UserTab(
            logouted: () {
              _currentIndex = 0;
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<UserProvider, User?>(
          bloc: BlocProvider.of<UserProvider>(context),
          builder: (context, user) {
            return BottomNavigationBar(
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
                  label: user == null ? '登录' : '我的',
                ),
              ],
              onTap: (index) {
                _handleTabChange(index, user != null);
              },
            );
          }),
    );
  }

  void _handleTabChange(int index, bool isLogin) {
    // 在这里执行你的自定义逻辑，例如拦截Tab切换
    if (index == 2 && !isLogin) {
      Navigator.of(context).pushNamed('/login');
    } else {
      // 允许切换到其他选项卡
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
