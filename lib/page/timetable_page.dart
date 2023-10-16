import 'package:flutter/material.dart';
import 'package:ifafu/page/tab_timetable.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TimetableTab(
        leading: BackButton(),
      ),
    );
  }
}
