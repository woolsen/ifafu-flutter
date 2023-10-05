class Chinese {

  static const _weekdayCN = ['日', '一', '二', '三', '四', '五', '六', '日'];

  Chinese._();

  static String getWeekdayCN(int weekday) {
    return _weekdayCN[weekday];
  }

}