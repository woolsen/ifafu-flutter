import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/chinese.dart';
import 'package:ifafu/util/extensions.dart';

class Timetable extends StatelessWidget {
  ///周偏移量，若在本周则为0，若在本周之前则为-，若在本周之后则为+
  final int offsetWeek;

  final int oneNodeLength;

  final List<Course> courses;

  final List<int>? times;

  final primaryColor = const Color(0xFF1185FD);

  final _leftTimeTextStyle = const TextStyle(
    fontSize: 9,
    color: Colors.black87,
  );

  final _leftNodeTextStyle = const TextStyle(
    fontSize: 13,
    color: Colors.black87,
    fontWeight: FontWeight.w500,
  );
  final _weekdayTextStyle = const TextStyle(
    fontSize: 13,
    color: Colors.black87,
  );

  final WidgetBuilder? empty;

  final void Function(Course) onCourseClick;

  static const _dividerHeight = 0.5;

  static const _horizontalDivider =
      Divider(thickness: _dividerHeight, height: _dividerHeight);

  final Widget Function(BuildContext context, int weekday)? weekdayBuilder;

  final bool showTime;

  Timetable({
    super.key,
    required this.offsetWeek,
    required this.courses,
    required this.times,
    required this.showTime,
    required this.oneNodeLength,
    required this.onCourseClick,
    this.weekdayBuilder,
    this.empty,
  });

  @override
  Widget build(BuildContext context) {
    List<List<Course>> c = List.generate(8, (index) => [], growable: false);
    for (var course in courses) {
      c[course.weekday].add(course);
    }
    const counter = 13;
    List<Widget> children = [];
    children.add(Expanded(
      flex: 1,
      child: _buildLeftNodeColumn(),
    ));
    for (int i = 1; i <= 7; i++) {
      int weekday = i == 1 ? 7 : i - 1;
      children.add(Expanded(
        flex: 2,
        child: _buildCourseColumn(
          context,
          weekday: weekday,
          counter: counter - 1,
          courses: c[weekday],
        ),
      ));
    }
    Widget body = Row(children: children);
    if (courses.isEmpty) {
      if (empty != null) {
        body = Stack(children: [
          Row(children: children),
          Center(
            child: empty!(context),
          ),
        ]);
      } else {
        body = Stack(children: [
          Row(children: children),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                height: 160,
                image: AssetImage("assets/image/empty.png"),
              ),
              Text(
                '这周没有课',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ]);
      }
    }
    return Column(
      children: [
        //上部星期栏
        _buildWeekdayRow(context),
        _horizontalDivider,
        //节数栏以及课程栏
        Expanded(
          child: body,
        ),
      ],
    );
  }

  /// 构建上部星期栏
  /// [sundayDateTime]周日的日期，即每周第一天的日期
  Widget _buildWeekdayRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: weekdayBuilder != null
              ? weekdayBuilder!(context, 0)
              : const SizedBox(height: 42),
        ),
        ...List.generate(7, (index) {
          if (weekdayBuilder != null) {
            return Expanded(flex: 2, child: weekdayBuilder!(context, index));
          }
          return Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                Chinese.getWeekdayCN(index),
                style: _weekdayTextStyle,
              ),
            ),
          );
        })
      ],
    );
  }

  /// 构建左边节数列
  Widget _buildLeftNodeColumn() {
    final currentTime = DateTime.now();
    final current = currentTime.hour * 100 + currentTime.minute;
    List<Widget> nodes = [];
    // 这边的Expanded是为了每行能平均分布
    for (int i = 1; i < 13; i++) {
      if (i != 1) {
        nodes.add(_horizontalDivider);
      }
      bool highLight = false;
      TextStyle leftTimeTextStyle = _leftTimeTextStyle;
      TextStyle leftNodeTextStyle = _leftNodeTextStyle;
      if (times != null) {
        final start = times![i];
        final end = addTime(times![i], oneNodeLength);
        highLight = offsetWeek == 0 && current > start && current < end;
        if (highLight) {
          leftTimeTextStyle = _leftTimeTextStyle.copyWith(
            color: primaryColor,
          );
          leftNodeTextStyle = _leftNodeTextStyle.copyWith(
            color: primaryColor,
          );
        }
      }
      nodes.add(Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: highLight ? const Color(0x8884FFFF) : null,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
          child: Stack(
            children: [
              if (showTime && times != null)
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '${times![i] ~/ 100}:${(times![i] % 100).toFix0String(2)}',
                      textAlign: TextAlign.center,
                      style: leftTimeTextStyle,
                    ),
                  ),
                ),
              Center(
                child: Text(
                  i.toString(),
                  style: leftNodeTextStyle,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return Column(children: nodes);
  }

  /// 构建课程列
  Widget _buildCourseColumn(BuildContext context,
      {required int weekday,
      required int counter,
      required List<Course> courses}) {
    courses.sort((a, b) => a.startNode - b.startNode);
    List<Widget> nodes = [];
    // 这边的Expanded是为了每行能平均分布
    // nodes.add(Expanded(child: _buildWeekdayNode(weekday, DateTime.now())));
    nodes.add(Container(
        color: Colors.cyanAccent.withAlpha(weekday * 10),
        child: Text(1.toString())));
    return LayoutBuilder(builder: (context, constraints) {
      List<Widget> views = [];
      var perWidth = constraints.maxWidth;
      var perHeight = (constraints.maxHeight + _dividerHeight) / counter;
      for (int i = 0; i < counter - 1; i++) {
        views.add(Positioned(
          top: perHeight * (i + 1) - _dividerHeight,
          width: perWidth,
          child: _horizontalDivider,
        ));
      }
      if (courses.isNotEmpty) {
        for (var course in courses) {
          views.add(Positioned(
            left: 0.1,
            top: perHeight * (course.startNode - 1) + 0.1,
            height: perHeight * course.nodeCount - 0.1,
            width: perWidth - 0.2,
            child: _buildCourseView(context, course),
          ));
        }
      }
      return Stack(
        children: views,
      );
    });
  }

  final colors = const [
    Colors.lightGreen,
    Colors.blue,
    Colors.green,
    Colors.lime,
    Colors.cyan,
    Colors.deepPurple,
    Colors.teal,
    Colors.red,
    Colors.pink,
    Colors.lightBlue,
    Colors.purple,
    Colors.deepOrange,
    Colors.indigo,
  ];

  final colorMap = <String>[];

  Widget _buildCourseView(BuildContext context, Course course) {
    var colorIndex = colorMap.indexOf(course.name);
    if (colorIndex == -1) {
      colorMap.add(course.name);
      colorIndex = colorMap.length - 1;
    }
    final color = colors[colorIndex % colors.length].shade400;
    return GestureDetector(
      onTap: () {
        onCourseClick(course);
      },
      child: Container(
          decoration: ShapeDecoration(
              color: color,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)))),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
                child: Text(
              "${course.name}@${course.location}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            )),
          )),
    );
  }

  int addTime(int time, [int? add]) {
    final int t;
    if (add != null) {
      final minute = time % 100;
      final addHour = (minute + add) ~/ 60;
      final lastMinute = (minute + add) % 60;
      t = time + 100 * addHour - minute + lastMinute;
    } else {
      t = time;
    }
    return t;
  }
}
