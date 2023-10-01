import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SnackBarUtil {

  SnackBarUtil._();

  static void show(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  static void error(
    BuildContext context,
    Exception e, {
    String? defaultMsg,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 1),
  }) {
    String message;
    if (e is DioException && e.message != null) {
      message = e.message!;
    } else if (defaultMsg != null) {
      message = defaultMsg;
    } else {
      message = e.toString();
    }
    show(context, message, action: action, duration: duration);
  }
}
