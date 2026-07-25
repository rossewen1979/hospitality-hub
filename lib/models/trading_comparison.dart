import 'trading_day.dart';

class TradingComparison {
  final TradingDay? today;
  final TradingDay? lastWeek;
  final TradingDay? lastYear;

  const TradingComparison({
    this.today,
    this.lastWeek,
    this.lastYear,
  });

  double get todayRevenue => today?.totalRevenue ?? 0;
  double get lastWeekRevenue => lastWeek?.totalRevenue ?? 0;
  double get lastYearRevenue => lastYear?.totalRevenue ?? 0;

  double get revenueVsLastWeek =>
      todayRevenue - lastWeekRevenue;

  double get revenueVsLastYear =>
      todayRevenue - lastYearRevenue;

  double get revenueVsLastWeekPercent {
    if (lastWeekRevenue == 0) return 0;

    return ((todayRevenue - lastWeekRevenue) /
            lastWeekRevenue) *
        100;
  }

  double get revenueVsLastYearPercent {
    if (lastYearRevenue == 0) return 0;

    return ((todayRevenue - lastYearRevenue) /
            lastYearRevenue) *
        100;
  }

  bool get hasToday => today != null;
  bool get hasLastWeek => lastWeek != null;
  bool get hasLastYear => lastYear != null;
}