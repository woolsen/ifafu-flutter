import 'package:dio/dio.dart';
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

  static void error(Object e, [String? defaultMsg]) {
    if (e is DioException && e.message != null) {
      show(e.message!);
    } else if (defaultMsg != null) {
      show(defaultMsg);
    } else {
      show(e.toString());
    }
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}
