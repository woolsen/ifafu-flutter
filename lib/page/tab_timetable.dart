import 'package:flutter/material.dart';

class TimetableTab extends StatefulWidget {
  const TimetableTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CourseTabState();
}

class _CourseTabState extends State<TimetableTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('课程表'),
      ),
    );
  }
}
