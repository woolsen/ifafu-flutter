import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {

  const DateTimeConverter();

  static final _formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  @override
  DateTime fromJson(String str) {
    return _formatter.parse(str);
  }

  @override
  String toJson(DateTime dateTime) {
    return _formatter.format(dateTime);
  }
}
