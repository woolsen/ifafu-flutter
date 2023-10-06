import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/chinese.dart';
import 'package:ifafu/util/extensions.dart';

class Timetable extends StatelessWidget {
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

  final void Function(List<Course>)? onCourseClick;

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
    this.onCourseClick,
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
  Widget _buildCourseColumn(
    BuildContext context, {
    required int weekday,
    required int counter,
    required List<Course> courses,
  }) {
    //先比较startNode再按照endNode排序
    courses.sort((a, b) {
      if (a.startNode == b.startNode) {
        return b.endNode - a.endNode;
      }
      return a.startNode - b.startNode;
    });
    List<List<Course>> courseList = [];
    List<List<Course>?> table = List.generate(
      counter + 1,
      (index) => null,
      growable: false,
    );
    for (var course in courses) {
      var addToList = false;
      for (int i = course.startNode; i <= course.endNode; i++) {
        if (table[i] == null) {
          table[i] = [];
          addToList = true;
        }
        table[i]!.add(course);
      }
      if (addToList) {
        courseList.add(table[course.startNode]!);
      }
    }

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
      for (var courses in courseList) {
        final course = courses.first;
        views.add(Positioned(
          left: 0.1,
          top: perHeight * (course.startNode - 1) + 0.1,
          height: perHeight * course.nodeCount - 0.1,
          width: perWidth - 0.2,
          child: GestureDetector(
            onTap: () {
              if (onCourseClick != null) {
                onCourseClick?.call(courses);
              } else {
                showAdaptiveDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return CourseDetailDialog(courses);
                  },
                );
              }
            },
            child: _buildCourseView(context, courses),
          ),
        ));
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

  Widget _buildCourseView(BuildContext context, List<Course> courses) {
    final first = courses.first;
    var colorIndex = colorMap.indexOf(first.name);
    if (colorIndex == -1) {
      colorMap.add(first.name);
      colorIndex = colorMap.length - 1;
    }
    final color = colors[colorIndex % colors.length];
    Widget child = Center(
      child: Text(
        "${first.name}@${first.location}",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
    if (courses.length > 1) {
      child = Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < courses.length; i++)
                  const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        height: 3,
                        width: 3,
                      ),
                    ),
                  )
              ],
            ),
          ),
          child,
        ],
      );
    }
    return Container(
      decoration: ShapeDecoration(
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.all(0.5),
      child: child,
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

class CourseDetailDialog extends StatelessWidget {
  final List<Course> courses;

  final TextStyle? titleTextStyle;
  final TextStyle? normalTextStyle;

  final TextStyle _weekCellTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    decoration: TextDecoration.none,
  );

  final _divider = const SizedBox(height: 14);

  const CourseDetailDialog(
    this.courses, {
    super.key,
    this.titleTextStyle,
    this.normalTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = this.titleTextStyle ??
        const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        );
    final normalTextStyle = this.normalTextStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        );

    Widget child;
    if (courses.isEmpty) {
      child = const SizedBox();
      child = Dialog(child: child);
    } else if (courses.length == 1) {
      child = _buildCourseDetail(
        context,
        courses.first,
        titleTextStyle,
        normalTextStyle,
      );
      child = Dialog(child: child);
    } else {
      child = PageView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              if (index != 0)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.keyboard_double_arrow_left_rounded,
                      size: 36,
                      color: Colors.grey,
                    ),
                  ),
                ),
              Center(
                child: Dialog(
                  child: _buildCourseDetail(
                      context, courses[index], titleTextStyle, normalTextStyle),
                ),
              ),
              if (index != courses.length - 1)
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      size: 36,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          );
        },
      );
      child = GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: child,
      );
    }
    return child;
  }

  Widget _buildCourseDetail(
    BuildContext context,
    Course course,
    TextStyle titleTextStyle,
    TextStyle normalTextStyle,
  ) {
    final String weekStr = '周${Chinese.getWeekdayCN(course.weekday)}';
    return SizedBox(
      width: 320,
      child: Stack(
        children: [
          Positioned(
            top: 14,
            right: 8,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.grey,
                  size: 24,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.name, style: titleTextStyle),
                const SizedBox(height: 18),
                _buildDetailText(
                  '教室',
                  course.location,
                  normalTextStyle,
                ),
                _divider,
                _buildDetailText(
                  '教师',
                  course.teacher,
                  normalTextStyle,
                ),
                _divider,
                _buildDetailText(
                  '上课时间',
                  '$weekStr 第${course.startNode}节-第${course.endNode}节',
                  normalTextStyle,
                ),
                _divider,
                Text(
                  '上课周次',
                  style: normalTextStyle.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                // const Divider(thickness: 2, height: 2, color: Colors.white),
                _buildWeeksTable(
                    course.weeks, Theme.of(context).colorScheme.surfaceTint),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeksTable(Set<int> weeks, color) {
    int index = 0;
    List<TableRow> rows = [];
    final int columnCount;
    final double height;
    if (weeks.isNotEmpty && weeks.maxOf((t) => t) > 20) {
      columnCount = 6;
      height = 40;
    } else {
      columnCount = 5;
      height = 48;
    }
    for (int i = 0; i < 4; i++) {
      final List<TableCell> cells = [];
      for (int j = 0; j < columnCount; j++) {
        index++;
        cells.add(TableCell(
          child: Container(
            margin: const EdgeInsets.all(1),
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: weeks.contains(index) ? color : Colors.black12,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              index.toString(),
              style: _weekCellTextStyle,
            ),
          ),
        ));
      }
      rows.add(TableRow(children: cells));
    }
    return Table(children: rows);
  }

  Widget _buildDetailText(String title, String text, TextStyle textStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 64,
          child: Text(
            title,
            style: textStyle.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            softWrap: true,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
