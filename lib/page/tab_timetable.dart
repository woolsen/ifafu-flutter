import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/page/bind_jw_page.dart';
import 'package:ifafu/page/timetable_set_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/chinese.dart';
import 'package:ifafu/util/sp.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/timetable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TimetableTab extends StatefulWidget {
  final Widget? leading;

  const TimetableTab({Key? key, this.leading}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimetableTabState();
}

class TimetableTabState extends State<TimetableTab> {
  final ValueNotifier<int> _showWeek = ValueNotifier(1);

  late PageController _pageController;

  final RefreshController _refreshController = RefreshController();

  final tableKey = GlobalKey(debugLabel: 'timetable_pages');

  List<int>? todayDateIndex;
  List<List<String>>? weekDateList;
  final List<List<Course>> coursesList = List.generate(23, (index) => []);

  bool init = false;

  int _currentWeek = 1;

  PersonalTimetable? _timetable;
  List<int>? _times;
  TimetableSet? _set;

  User? _user;

  final titleStyle = const TextStyle(
    fontSize: 20,
    height: 1.0,
    fontFamily: 'DingTalk',
  );

  @override
  void initState() {
    super.initState();
    _user = BlocProvider.of<UserProvider>(context).state;
    final timetable = _loadLocalTimetable();
    if (timetable == null) {
      Api.instance.getPersonalTimetable().then((timetable) {
        _updateTimetable(timetable);
        _saveTimetable(timetable);
      }).whenComplete(() {
        init = true;
      });
    } else {
      _updateTimetable(timetable);
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    TimetableSet setting = _set ??= loadTimeTableSetting();
    File? background =
        setting.backgroundPath == null ? null : File(setting.backgroundPath!);
    return Stack(
      fit: StackFit.expand,
      children: [
        if (background != null)
          FutureBuilder(
            future: background.exists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox();
              }
              return Positioned.fill(
                child: Image.file(
                  background,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        BlocListener<UserProvider, User?>(
          bloc: BlocProvider.of<UserProvider>(context),
          listener: (context, user) {
            _user = user;
            if (user != null && user.isBindJw) {
              Api.instance.getPersonalTimetable().then((timetable) {
                _updateTimetable(timetable);
                _saveTimetable(timetable);
              });
            } else {
              setState(() {});
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _buildAppbar(() {
                if (!init) {
                  return Text('加载中', style: titleStyle);
                } else if (_user == null) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text('点击登录', style: titleStyle),
                  );
                } else if (!_user!.isBindJw) {
                  return GestureDetector(
                    onTap: _goToBindJwPage,
                    child: Text('点击绑定', style: titleStyle),
                  );
                } else if (_timetable == null) {
                  return Text('加载失败', style: titleStyle);
                } else {
                  return null;
                }
              }),
            ),
            body: Builder(
              builder: (context) {
                if (_user == null) {
                  return Center(
                    child: _buildEmptyView(
                      '请先登录',
                      text: '点击登录',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                    ),
                  );
                }
                if (!_user!.isBindJw) {
                  return Center(
                    child: _buildEmptyView(
                      '绑定教务系统，即可查看课表',
                      text: '点击绑定',
                      onPressed: _goToBindJwPage,
                    ),
                  );
                }
                return _timetable == null
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox.expand(
                        child: SmartRefresher(
                          controller: _refreshController,
                          onRefresh: refresh,
                          enablePullUp: false,
                          child: _buildTimetableBody(_user!, setting),
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _saveTimetable(PersonalTimetable timetable) {
    SPUtil.setString('TIMETABLE', jsonEncode(timetable.toJson()));
  }

  PersonalTimetable? _loadLocalTimetable() {
    final timetableJSON = SPUtil.getString('TIMETABLE');
    if (timetableJSON != null) {
      try {
        return PersonalTimetable.fromJson(jsonDecode(timetableJSON));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  void _updateTimetable(PersonalTimetable timetable) {
    _timetable = timetable;
    for (var courses in coursesList) {
      courses.clear();
    }

    for (var course in timetable.courses) {
      for (var week in course.weeks) {
        coursesList[week].add(course);
      }
    }
    var current = DateTime.now();

    var date = timetable.openDay
        .subtract(Duration(days: timetable.openDay.weekday % 7));
    var currentWeek = current.difference(date).inDays ~/ 7 + 1;

    var weekDateList = <List<String>>[];
    for (int i = 0; i < 23; i++) {
      var weekDate = <String>[];
      weekDate.add('${date.month}');
      for (int j = 0; j < 7; j++) {
        weekDate.add('${date.day}');
        date = date.add(const Duration(days: 1));
      }
      weekDateList.add(weekDate);
    }
    this.weekDateList = weekDateList;

    todayDateIndex = [currentWeek, current.weekday];

    if (_set != null && _set!.timeIndex == null) {
      var isQS = _timetable!.courses.any((e) {
        return e.location.contains('旗山') || e.location.contains('旗教');
      });
      _times = TimetableSet.times[isQS ? 1 : 0];
    } else if (_set != null && _set!.timeIndex != null) {
      _times = TimetableSet.times[_set!.timeIndex!];
    }

    if (_currentWeek != currentWeek) {
      _currentWeek = currentWeek;
      _showWeek.value = _currentWeek;
    }

    _pageController = PageController(initialPage: _currentWeek - 1);
    if (!init) {
      init = true;
    }
    setState(() {});
  }

  TimetableSet loadTimeTableSetting() {
    final settingJSON = SPUtil.getString('TIMETABLE_SETTING');
    if (settingJSON == null) {
      return TimetableSet();
    } else {
      try {
        return TimetableSet.fromJson(jsonDecode(settingJSON));
      } catch (e) {
        return TimetableSet();
      }
    }
  }

  Widget _buildEmptyView(
    String message, {
    String? text,
    VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/image/empty.png', height: 120),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        if (text != null) ...[
          const SizedBox(height: 8),
          if (onPressed == null)
            Text(
              text,
            )
          else
            ElevatedButton(
              onPressed: onPressed,
              child: Text(text),
            ),
        ],
      ],
    );
  }

  /// [currentWeek] 本周的周数
  Widget _buildAppbar(Widget? Function() centerBuilder) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (widget.leading != null)
            Align(
              alignment: Alignment.centerLeft,
              child: widget.leading!,
            ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _gotoSetting(),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: centerBuilder() ??
                ValueListenableBuilder(
                  valueListenable: _showWeek,
                  builder: (context, data, _) {
                    final int showWeek = data;
                    final WeekState? weekState;
                    final String weekStateStr;
                    if (_currentWeek == -1) {
                      weekState = WeekState.vacation;
                      weekStateStr = '放假中';
                    } else if (_currentWeek == showWeek) {
                      weekState = WeekState.currentWeek;
                      weekStateStr = '';
                    } else {
                      weekState = WeekState.notCurrentWeek;
                      weekStateStr = '长按回到本周';
                    }
                    return GestureDetector(
                      onLongPress: () async {
                        int? toPage;
                        if (weekState == WeekState.vacation) {
                          toPage = 0;
                        } else if (weekState != null) {
                          toPage = _currentWeek - 1;
                        }
                        if (toPage != null) {
                          _pageController.animateToPage(
                            toPage,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastEaseInToSlowEaseOut,
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '第$showWeek周',
                            style: const TextStyle(
                              fontSize: 20,
                              height: 1.0,
                              fontFamily: 'DingTalk',
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            height: weekState == WeekState.currentWeek ? 0 : 16,
                            transformAlignment: Alignment.center,
                            child: Text(
                              weekStateStr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimetableBody(User user, TimetableSet set) {
    final highlightColor =
        Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8);
    return PageView.builder(
      onPageChanged: (page) {
        _showWeek.value = page + 1;
      },
      pageSnapping: true,
      allowImplicitScrolling: false,
      controller: _pageController,
      itemCount: coursesList.length - 1,
      itemBuilder: (context, index) {
        final showWeekCourses =
            !user.isBindJw ? <Course>[] : coursesList[index + 1];
        final weekDates = weekDateList![index];
        return Timetable(
          key: ValueKey(showWeekCourses),
          courses: showWeekCourses,
          times: set.showTime && _times != null ? _times! : null,
          weekdayBuilder: (context, weekday) {
            String date = weekDates[weekday % 7 + 1];
            bool today = false;
            Widget child;
            if (weekday == 0) {
              child = Text(
                '${weekDates[0]}\n月',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              today = todayDateIndex![0] == index + 1 && todayDateIndex![1] == weekday;
              child = Column(
                children: [
                  Text(
                    Chinese.getWeekdayCN(weekday),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: today ? Colors.blueAccent : null,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 11,
                      color: today ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                ],
              );
            }
            child = Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: child,
            );
            if (today) {
              child = DecoratedBox(
                decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: child,
              );
            }
            return child;
          },
          emptyBuilder: (context) {
            return _buildEmptyView('这周没有课哦~');
          },
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
      refresh();
    }
  }

  void _gotoSetting() async {
    var size = tableKey.currentContext?.size ?? MediaQuery.of(context).size;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimetableSetPage(
          set: _set ?? TimetableSet(),
          backgroundRatio: CropAspectRatio(
            ratioX: size.width,
            ratioY: size.height,
          ),
          updated: (setting) async {
            SPUtil.setString('TIMETABLE_SETTING', jsonEncode(setting));
            _set = setting;
            setState(() {});
          },
        ),
      ),
    );
  }

  void refresh() {
    Api.instance.refreshPersonalTimetable().then((value) {
      _updateTimetable(value);
      _saveTimetable(value);
      _refreshController.refreshCompleted();
      ToastUtil.show('刷新成功');
    }).catchError((e) {
      ToastUtil.error(e);
      _refreshController.refreshFailed();
    });
  }
}

enum WeekState {
  vacation,
  currentWeek,
  notCurrentWeek;
}
