import 'package:flutter/material.dart';

Future<String?> showSimpleDialog(BuildContext context, List<String> list) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text('请选择'),
        children: list.map((e) {
          return SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, e);
            },
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                e,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        }).toList(),
      );
    },
  );
}
