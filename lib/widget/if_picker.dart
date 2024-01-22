import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';

class IFPicker extends StatelessWidget {
  final List<int>? selected;
  final List<PickerItem<String>> data;
  final PickerConfirmCallback? onConfirm;

  const IFPicker(
      {super.key, this.selected, required this.data, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final picker = Picker(
      height: 240,
      containerColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      adapter: PickerDataAdapter<String>(data: data),
      hideHeader: true,
      selecteds: selected,
      onBuilderItem: (context, text, child, bool selected, col, index) {
        return Text(
          text ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        );
      },
      onConfirm: onConfirm,
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
                  '选择学期',
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
          picker.makePicker(),
        ],
      ),
    );
  }
}
