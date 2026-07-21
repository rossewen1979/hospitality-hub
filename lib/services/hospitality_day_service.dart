class HospitalityDayService {
  static const int tradingDayStartsAtHour = 5;

  /// Returns the hospitality trading day.
  ///
  /// Example:
  /// 02:30 Saturday -> Friday
  /// 10:00 Saturday -> Saturday
  static DateTime currentTradingDate([DateTime? now]) {
    final dateTime = now ?? DateTime.now();

    if (dateTime.hour < tradingDayStartsAtHour) {
      final previousDay = dateTime.subtract(
        const Duration(days: 1),
      );

      return DateTime(
        previousDay.year,
        previousDay.month,
        previousDay.day,
      );
    }

    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
  }

  /// Returns an ID such as:
  /// 2026-07-20
  static String tradingDayId([DateTime? now]) {
    final tradingDay = currentTradingDate(now);

    final month =
        tradingDay.month.toString().padLeft(2, '0');

    final day =
        tradingDay.day.toString().padLeft(2, '0');

    return '${tradingDay.year}-$month-$day';
  }

  /// Returns the Monday of the hospitality trading week.
  static DateTime startOfTradingWeek([DateTime? now]) {
    final tradingDay = currentTradingDate(now);

    return tradingDay.subtract(
      Duration(days: tradingDay.weekday - DateTime.monday),
    );
  }

  /// Returns the Sunday of the hospitality trading week.
  static DateTime endOfTradingWeek([DateTime? now]) {
    return startOfTradingWeek(now).add(
      const Duration(days: 6),
    );
  }

  /// True if the supplied trading date falls within
  /// the current hospitality trading week.
  static bool isInCurrentTradingWeek(
    DateTime tradingDate, [
    DateTime? now,
  ]) {
    final start = startOfTradingWeek(now);
    final end = endOfTradingWeek(now);

    return !tradingDate.isBefore(start) &&
        !tradingDate.isAfter(end);
  }

  /// Monday-Sunday dates for the current trading week.
  static List<DateTime> currentTradingWeek([DateTime? now]) {
    final start = startOfTradingWeek(now);

    return List.generate(
      7,
      (index) => start.add(Duration(days: index)),
    );
  }
}