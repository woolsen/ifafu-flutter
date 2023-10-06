import 'package:flutter/material.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/widget/timetable.dart';
import 'package:intl/intl.dart';

class MajorTimetablePage extends StatefulWidget {
  final int timetableId;

  const MajorTimetablePage(this.timetableId, {super.key});

  @override
  State<MajorTimetablePage> createState() => _MajorTimetablePageState();
}

class _MajorTimetablePageState extends State<MajorTimetablePage> {
  MajorTimetable? timetable;

  @override
  void initState() {
    super.initState();
    Api.instance.getMajorTimetable(widget.timetableId).then((value) {
      timetable = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (timetable != null)
              Text('${timetable!.clazz}课表')
            else
              const Text('专业课表'),
            if (timetable != null)
              Text(
                '更新于${DateFormat('yyyy-MM-dd HH:mm:ss').format(timetable!.updateTime)}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Timetable(
          courses: timetable?.courses ?? [],
        ),
      ),
    );
  }

  Future<MajorTimetable> getMajorTimetable() async {
    return await Api.instance.getMajorTimetable(widget.timetableId);
  }
}
