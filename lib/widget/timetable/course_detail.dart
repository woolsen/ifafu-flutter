import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/extensions.dart';

class CourseDetail extends StatelessWidget {
  final Course course;

  final TextStyle? titleTextStyle;
  final TextStyle? normalTextStyle;

  final TextStyle _weekCellTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    decoration: TextDecoration.none,
  );

  final _divider = const SizedBox(height: 14);

  const CourseDetail(this.course, {
    super.key,
    this.titleTextStyle,
    this.normalTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final titleTextStyle = this.titleTextStyle ?? const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );
    final normalTextStyle = this.normalTextStyle ?? const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
    );
    final String weekStr;
    switch (course.weekday) {
      case 1:
        weekStr = '周一';
        break;
      case 2:
        weekStr = '周二';
        break;
      case 3:
        weekStr = '周三';
        break;
      case 4:
        weekStr = '周四';
        break;
      case 5:
        weekStr = '周五';
        break;
      case 6:
        weekStr = '周六';
        break;
      case 7:
        weekStr = '周日';
        break;
      default:
        weekStr = '';
        break;
    }
    return Center(
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.grey,
                  size: 24,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name, style: titleTextStyle),
                  const SizedBox(height: 24),
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
                  _buildWeeksTable(course.weeks, primaryColor),
                ],
              ),
            ),
          ],
        ),
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
            margin: const EdgeInsets.all(0.5),
            height: height,
            alignment: Alignment.center,
            color: weeks.contains(index) ? color : Colors.black12,
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
