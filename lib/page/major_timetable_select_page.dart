import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/page/major_timetable_page.dart';
import 'package:ifafu/util/toast.dart';

import '../http/model.dart';

class MajorTimetableSelectPage extends StatefulWidget {
  const MajorTimetableSelectPage({super.key});

  @override
  State<MajorTimetableSelectPage> createState() =>
      _MajorTimetableSelectPageState();
}

class _MajorTimetableSelectPageState extends State<MajorTimetableSelectPage> {
  String? selectedClass;
  int? selectedId;

  MajorTimetableOptions? options;
  var pickItems = <PickerItem<String>>[];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Api.instance.getMajorTimetableOptions().then((value) {
      options = value;
      pickItems = value.entries.map((e) {
        return PickerItem<String>(
          text: Text(e.key),
          value: e.key,
          children: e.value.entries.map((e) {
            return PickerItem<String>(
              text: Text(e.key),
              value: e.key,
              children: e.value.entries.map((e) {
                return PickerItem<String>(
                  text: Text(e.key),
                  value: e.key,
                );
              }).toList(),
            );
          }).toList(),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('专业课表'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          alignment: Alignment.topCenter,
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 72),
              const Text(
                'iFAFU',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'DingTalk',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '专业课表查询\n可查询2023级新生课表',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 28),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '选择查询的班级',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Divider(),
              SizedBox(
                height: 48,
                child: GestureDetector(
                  onTap: () => showClassPicker(context),
                  child: Row(
                    children: [
                      const Text(
                        '查询班级',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Text(
                          selectedClass ?? '点击选择班级',
                          style: TextStyle(
                            fontSize: 15,
                            color: selectedClass == null
                                ? Theme.of(context).hintColor
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 48),
                ),
                onPressed: query,
                child: const Text('立即查询'),
              ),
              const SizedBox(height: 16),
              const Text(
                'PS：专业课表仅用于预览班级课程，与实际课表有出入，具体课表见个人课表（首页-课表）',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showClassPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        var picker = Picker(
          height: 240,
          containerColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          adapter: PickerDataAdapter<String>(data: pickItems),
          hideHeader: true,
          selecteds: [0, 0, 0],
          textStyle: const TextStyle(
            fontSize: 12,
          ),
          onBuilderItem: (context, String? text, Widget? child, bool selected,
              int col, int index) {
            return Text(
              text ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            );
          },
          onConfirm: (Picker picker, List<int> value) {
            var p1 = pickItems[value[0]];
            var p2 = p1.children![value[1]];
            var p3 = p2.children![value[2]];
            selectedClass = p3.value;
            selectedId = options![p1.value]![p2.value]![p3.value]!;
            setState(() {});
          },
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        picker.doCancel(context);
                      },
                      child: const Text('取消'),
                    ),
                  ),
                  const Center(
                    child: Text(
                      '选择班级',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        picker.doConfirm(context);
                      },
                      child: const Text('确定'),
                    ),
                  ),
                ],
              ),
              picker.makePicker(theme),
            ],
          ),
        );
      },
    );
  }

  void query() {
    if (selectedId == null) {
      ToastUtil.show('请选择班级');
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MajorTimetablePage(selectedId!);
    }));
  }
}
