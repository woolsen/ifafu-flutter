import 'package:intl/intl.dart';

String formatTime(DateTime time, {DateTime? now}) {
  final DateTime currentTime = now ?? DateTime.now();
  currentTime.subtract(Duration(
    hours: currentTime.hour,
    minutes: currentTime.minute,
    seconds: currentTime.second,
    milliseconds: currentTime.millisecond,
    microseconds: currentTime.microsecond,
  ));
  final Duration difference = currentTime.difference(time);
  if (difference < const Duration(days: 1)) {
    return DateFormat('今天HH:mm').format(time);
  } else if (difference < const Duration(days: 2)) {
    return DateFormat('昨天HH:mm').format(time);
  } else if (difference < const Duration(days: 3)) {
    return DateFormat('前天HH:mm').format(time);
  } else if (time.year == currentTime.year) {
    return DateFormat('M月d日 HH:mm').format(time);
  } else {
    return DateFormat('yyyy年M月d日 HH:mm').format(time);
  }
}
