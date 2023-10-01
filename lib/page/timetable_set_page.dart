import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/file.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class TimetableSetPage extends StatefulWidget {
  final TimetableSet set;

  final CropAspectRatio backgroundRatio;

  final void Function(TimetableSet) updated;

  const TimetableSetPage({
    Key? key,
    required this.set,
    required this.backgroundRatio,
    required this.updated,
  }) : super(key: key);

  @override
  State<TimetableSetPage> createState() => _TimetableSetPageState();
}

class _TimetableSetPageState extends State<TimetableSetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('课表设置')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('上课时间'),
            onTap: () => _showTimeSetting(context),
            trailing: Text(
              widget.set.timeIndex != null
                  ? widget.set.timeIndex == 0
                      ? '8:00开始'
                      : '8:20开始'
                  : '自动设置',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFA3A3A3),
              ),
            ),
          ),
          const Divider(),
          SwitchListTile.adaptive(
            value: widget.set.showTime,
            title: const Text('显示上课时间'),
            onChanged: (checked) {
              setState(() {
                widget.set.showTime = !widget.set.showTime;
              });
              widget.updated(widget.set);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('课表背景'),
            subtitle: const Text('长按重置背景'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _selectBackground(context),
            onLongPress: () => _resetBackground(),
          ),
        ],
      ),
    );
  }

  void _showTimeSetting(BuildContext context) async {
    final index = await showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (context) => TimeSetting(timeIndex: widget.set.timeIndex),
    );
    if (index == null) {
      return;
    }
    widget.set.timeIndex = index;
    setState(() {});
    widget.updated(widget.set);
  }

  void _resetBackground() async {
    if (widget.set.backgroundPath != null) {
      await FileUtils.delete(widget.set.backgroundPath!);
    }
    ToastUtil.show('背景已重置');
    widget.set.backgroundPath = null;
    widget.updated(widget.set);
  }

  void _selectBackground(BuildContext context) async {
    final asset = await ImagePicker.pickWithCrop(
      context,
      aspectRatio: widget.backgroundRatio,
    );
    if (asset == null) {
      return;
    }
    if (widget.set.backgroundPath != null) {
      await FileUtils.delete(widget.set.backgroundPath!);
    }
    File file = await FileUtils.save(
      'timetableBg${DateTime.now().millisecondsSinceEpoch}.jpg',
      asset,
    );
    widget.set.backgroundPath = file.path;
    widget.updated(widget.set);
  }
}

class TimeSetting extends StatefulWidget {
  final int? timeIndex;

  const TimeSetting({Key? key, required this.timeIndex}) : super(key: key);

  @override
  State<TimeSetting> createState() => _TimeSettingState();
}

class _TimeSettingState extends State<TimeSetting> {
  final primaryColor = const Color(0xFF1976D2);

  final secondaryColor = const Color(0xFFA3A3A3);

  int? _index;

  @override
  void initState() {
    super.initState();
    _index = widget.timeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(14),
        width: 240,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '设置作息时间',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 14),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: _buildSelectItem(
                        onTap: () => updateSetting(0),
                        selected: _index == 0,
                        title: '8:00开始',
                        subtitle: '（本部、安溪）',
                        height: 120,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildSelectItem(
                        onTap: () => updateSetting(1),
                        selected: _index == 1,
                        title: '8:20开始',
                        subtitle: '（旗山）',
                        height: 120,
                        width: double.infinity,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                _buildSelectItem(
                  onTap: () => updateSetting(null),
                  selected: _index == null,
                  title: '自动设置',
                  subtitle: '根据课表自动选择',
                  width: double.infinity,
                  height: 72,
                ),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: _buildConfirmButton(),
            ),
          ],
        ),
      ),
    );
  }

  void updateSetting(int? index) {
    setState(() {
      _index = index;
    });
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context, _index);
      },
      child: const Text('确定'),
    );
  }

  Widget _buildSelectItem({
    required GestureTapCallback onTap,
    required String title,
    required String subtitle,
    required bool selected,
    double? height,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: selected ? const Color(0xFF1976D2) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: selected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
