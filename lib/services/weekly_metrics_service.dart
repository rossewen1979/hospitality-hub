import '../models/trading_day.dart';
import 'hospitality_day_service.dart';
import 'hospitality_metrics.dart';
import 'storage_service.dart';

class WeeklyMetricsService {
  static Future<HospitalityMetrics> currentWeekMetrics() async {
    final allTradingDays =
        await StorageService.loadAllTradingDays();

    final thisWeek = allTradingDays.where(
      (TradingDay day) => HospitalityDayService
          .isInCurrentTradingWeek(day.tradingDate),
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
}