import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/chinese.dart';
import 'package:ifafu/util/extensions.dart';

class Timetable extends StatelessWidget {
  final int oneNodeLength;

  final List<Course> courses;

  final List<int>? times;

  final primaryColor = const Color(0xFF1185FD);

  final _leftTimeTextStyle = const TextStyle(
    fontSize: 9,
    color: Colors.grey,
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

  final WidgetBuilder? emptyBuilder;

  final void Function(Course) onCourseClick;

  static const _dividerHeight = 0.5;

  static const _horizontalDivider = Divider(
    thickness: _dividerHeight,
    height: _dividerHeight,
    color: Color(0x33333333),
  );

  final Widget Function(BuildContext context, int weekday)? weekdayBuilder;

  Timetable({
    super.key,
    required this.courses,
    required this.oneNodeLength,
    required this.onCourseClick,
    this.times,
    this.weekdayBuilder,
    this.emptyBuilder,
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
      if (emptyBuilder != null) {
        body = Stack(children: [
          Row(children: children),
          Center(
            child: emptyBuilder!(context),
          ),
        ]);
      } else {
        body = Stack(children: [
          Row(children: children),
          const Center(
            child: Column(
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
            ),
          )
        ]);
      }
    }
    return Column(
      children: [
        //上部星期栏
        _buildWeekdayRow(context), _horizontalDivider, //节数栏以及课程栏
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
            return Expanded(
                flex: 2,
                child: weekdayBuilder!(context, index == 0 ? 7 : index));
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
    List<Widget> nodes = [];
    // 这边的Expanded是为了每行能平均分布
    for (int i = 1; i < 13; i++) {
      if (i != 1) {
        nodes.add(_horizontalDivider);
      }
      TextStyle leftTimeTextStyle = _leftTimeTextStyle;
      TextStyle leftNodeTextStyle = _leftNodeTextStyle;
      nodes.add(Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Stack(
            children: [
              if (times != null)
                Positioned(
                  top: 1,
                  left: 0,
                  right: 0,
                  child: Text(
                    '${times![i] ~/ 100}:${(times![i] % 100).toFix0String(2)}',
                    textAlign: TextAlign.center,
                    style: leftTimeTextStyle,
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

  final List<Color> colors = [
    const Color(0xFFCE7CF4),
    const Color(0xFFFF7171),
    const Color(0xFF66CC99),
    const Color(0xFFFF9966),
    const Color(0xFF66CCCC),
    const Color(0xFF6699CC),
    const Color(0xFF99CC99),
    const Color(0xFF669966),
    const Color(0xFF66CCFF),
    const Color(0xFF99CC66),
    const Color(0xFFFF9999),
    const Color(0xFF81CC74),
  ];

  final colorMap = <String>[];

  Widget _buildCourseView(BuildContext context, Course course) {
    var colorIndex = colorMap.indexOf(course.name);
    if (colorIndex == -1) {
      colorMap.add(course.name);
      colorIndex = colorMap.length - 1;
    }
    final color = colors[colorIndex % colors.length];
    return GestureDetector(
      onTap: () {
        onCourseClick(course);
      },
      child: Container(
        decoration: ShapeDecoration(
          color: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(0.5),
        child: Center(
          child: Text(
            "${course.name}@${course.location}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ),
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
