import '../models/revenue_breakdown.dart';
import '../models/trading_comparison.dart';
import '../models/trading_day.dart';
import 'hospitality_day_service.dart';
import 'hospitality_metrics.dart';
import 'storage_service.dart';

class WeeklyMetricsService {
  static Future<HospitalityMetrics> currentWeekMetrics() async {
    final allTradingDays = await StorageService.loadAllTradingDays();

    final thisWeek = allTradingDays.where(
      (TradingDay day) =>
          HospitalityDayService.isInCurrentTradingWeek(day.tradingDate),
    );

    double wetRevenue = 0;
    double foodRevenue = 0;
    double otherRevenue = 0;
    double labourCost = 0;

    for (final day in thisWeek) {
      wetRevenue += day.wetRevenue;
      foodRevenue += day.foodRevenue;
      otherRevenue += day.otherRevenue;
      labourCost += day.labourCost;
    }

    return HospitalityMetrics(
      wetRevenue: wetRevenue,
      foodRevenue: foodRevenue,
      otherRevenue: otherRevenue,
      labourCost: labourCost,
    );
  }

  static Future<RevenueBreakdown> revenueBreakdown() async {
    final metrics = await currentWeekMetrics();

    return RevenueBreakdown(
      wetRevenue: metrics.wetRevenue,
      foodRevenue: metrics.foodRevenue,
      otherRevenue: metrics.otherRevenue,
    );
  }

  static Future<int> tradingDaysEnteredThisWeek() async {
    final allTradingDays = await StorageService.loadAllTradingDays();

    return allTradingDays.where(
      (TradingDay day) =>
          HospitalityDayService.isInCurrentTradingWeek(day.tradingDate),
    ).length;
  }

  static Future<double> averageRevenueThisWeek() async {
    final metrics = await currentWeekMetrics();
    final days = await tradingDaysEnteredThisWeek();

    if (days == 0) return 0;

    return metrics.totalRevenue / days;
  }

  static Future<double> highestRevenueThisWeek() async {
    final allTradingDays = await StorageService.loadAllTradingDays();

    final thisWeek = allTradingDays.where(
      (TradingDay day) =>
          HospitalityDayService.isInCurrentTradingWeek(day.tradingDate),
    );

    if (thisWeek.isEmpty) return 0;

    return thisWeek
        .map((d) => d.totalRevenue)
        .reduce((a, b) => a > b ? a : b);
  }

  static Future<double> lowestRevenueThisWeek() async {
    final allTradingDays = await StorageService.loadAllTradingDays();

    final thisWeek = allTradingDays.where(
      (TradingDay day) =>
          HospitalityDayService.isInCurrentTradingWeek(day.tradingDate),
    );

    if (thisWeek.isEmpty) return 0;

    return thisWeek
        .map((d) => d.totalRevenue)
        .reduce((a, b) => a < b ? a : b);
  }

  /// Returns today's trading day together with the
  /// equivalent trading day last week and last year.
  ///
  /// Last year uses 364 days to keep the weekday aligned,
  /// which is more useful for hospitality reporting.
  static Future<TradingComparison> tradingComparison() async {
    final tradingDays = await StorageService.loadAllTradingDays();

    final today =
        HospitalityDayService.currentTradingDate();

    final lastWeek = today.subtract(
      const Duration(days: 7),
    );

    final lastYear = today.subtract(
      const Duration(days: 364),
    );

    TradingDay? find(DateTime date) {
      try {
        return tradingDays.firstWhere(
          (day) =>
              day.tradingDate.year == date.year &&
              day.tradingDate.month == date.month &&
              day.tradingDate.day == date.day,
        );
      } catch (_) {
        return null;
      }
    }

    return TradingComparison(
      today: find(today),
      lastWeek: find(lastWeek),
      lastYear: find(lastYear),
    );
  }
}