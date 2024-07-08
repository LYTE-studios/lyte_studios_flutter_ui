class LyteDateTimeUtil {
  static String formatTimeNumber(int number) {
    String time = number.toString();

    if (time.length >= 2) {
      return time;
    }

    return '0$time';
  }
}
