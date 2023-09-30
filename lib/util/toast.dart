import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: const Color(0xEE333333),
    );
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}
