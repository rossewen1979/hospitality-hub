import '../models/trading_day.dart';
import 'hospitality_day_service.dart';
import 'hospitality_metrics.dart';
import 'storage_service.dart';

class TradingMetricsService {
  static Future<HospitalityMetrics> today() async {
    final id = HospitalityDayService.tradingDayId();

    final tradingDay = await StorageService.loadTradingDay(id);

    if (tradingDay == null) {
      return const HospitalityMetrics(
        wetRevenue: 0,
        foodRevenue: 0,
        otherRevenue: 0,
        labourCost: 0,
      );
    }

    return HospitalityMetrics(
      wetRevenue: tradingDay.wetRevenue,
      foodRevenue: tradingDay.foodRevenue,
      otherRevenue: tradingDay.otherRevenue,
      labourCost: tradingDay.labourCost,
    );
  }

  static Future<HospitalityMetrics> thisWeek() async {
    final tradingDays = await StorageService.loadAllTradingDays();

    double wet = 0;
    double food = 0;
    double other = 0;
    double labour = 0;

    for (final TradingDay day in tradingDays) {
      if (!HospitalityDayService.isInCurrentTradingWeek(
        day.tradingDate,
      )) {
        continue;
      }

      wet += day.wetRevenue;
      food += day.foodRevenue;
      other += day.otherRevenue;
      labour += day.labourCost;
    }

    return HospitalityMetrics(
      wetRevenue: wet,
      foodRevenue: food,
      otherRevenue: other,
      labourCost: labour,
    );
  }
}