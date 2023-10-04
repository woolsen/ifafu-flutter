import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/page/tab_main.dart';
import 'package:ifafu/page/tab_timetable.dart';
import 'package:ifafu/page/tab_user.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/sp.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int _selectedIndex = 0;

  var lastFetchUserInfoTime = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    // 注册WidgetsBindingObserver以监听应用程序生命周期状态
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
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
    if (SPUtil.getString('TOKEN') == null) {
      return;
    }
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
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const MainTab(), // const TimetableTab(),
          const TimetableTab(
            key: Key('timetable'),
          ),
          UserTab(
            logouted: () {
              _selectedIndex = 0;
              setState(() {});
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<UserProvider, User?>(
        bloc: BlocProvider.of<UserProvider>(context),
        builder: (context, user) {
          return NavigationBars(
            onSelectItem: (index) {
              _handleTabChange(index, user != null);
            },
            selectedIndex: _selectedIndex,
          );
        },
      ),
    );
  }

  void _handleTabChange(int index, bool isLogin) {
    // 在这里执行你的自定义逻辑，例如拦截Tab切换
    if (index == 2 && !isLogin) {
      Navigator.of(context).pushNamed('/login');
    } else {
      // 允许切换到其他选项卡
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}

class NavigationBars extends StatefulWidget {
  const NavigationBars({
    super.key,
    this.onSelectItem,
    required this.selectedIndex,
  });

  final void Function(int)? onSelectItem;
  final int selectedIndex;

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant NavigationBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //阴影
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // 阴影颜色和透明度
            blurRadius: 10, // 阴影的模糊程度
            spreadRadius: 2, // 阴影的扩散程度
            offset: Offset(0, 4), // 阴影的偏移量
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        // backgroundColor: const Color(0xFFF3ECFA),
        surfaceTintColor: Colors.transparent,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onSelectItem!(index);
        },
        destinations: appBarDestinations,
      ),
    );
  }
}

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.home_outlined),
    label: '首页',
    selectedIcon: Icon(Icons.home),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.calendar_month_outlined),
    label: '课表',
    selectedIcon: Icon(Icons.calendar_month),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.person_outline_sharp),
    label: '我的',
    selectedIcon: Icon(Icons.person_sharp),
  ),
];
