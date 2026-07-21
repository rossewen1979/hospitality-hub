import 'package:flutter/material.dart';

import '../models/trading_day.dart';
import '../services/hospitality_day_service.dart';
import '../services/hospitality_metrics.dart';
import '../services/storage_service.dart';

class TradingDayController extends ChangeNotifier {
  final wetRevenueController = TextEditingController();
  final foodRevenueController = TextEditingController();
  final otherRevenueController = TextEditingController();
  final labourCostController = TextEditingController();

  bool loading = true;
  bool completed = false;

  TradingDayController() {
    wetRevenueController.addListener(_onChanged);
    foodRevenueController.addListener(_onChanged);
    otherRevenueController.addListener(_onChanged);
    labourCostController.addListener(_onChanged);
  }

  double _parse(TextEditingController controller) {
    return double.tryParse(
          controller.text.replaceAll(',', ''),
        ) ??
        0;
  }

  HospitalityMetrics get metrics => HospitalityMetrics(
        wetRevenue: _parse(wetRevenueController),
        foodRevenue: _parse(foodRevenueController),
        otherRevenue: _parse(otherRevenueController),
        labourCost: _parse(labourCostController),
      );

  Future<void> load() async {
    loading = true;
    notifyListeners();

    final tradingDay = await StorageService.loadTradingDay(
      HospitalityDayService.tradingDayId(),
    );

    if (tradingDay != null) {
      wetRevenueController.text =
          tradingDay.wetRevenue.toStringAsFixed(2);

      foodRevenueController.text =
          tradingDay.foodRevenue.toStringAsFixed(2);

      otherRevenueController.text =
          tradingDay.otherRevenue.toStringAsFixed(2);

      labourCostController.text =
          tradingDay.labourCost.toStringAsFixed(2);

      completed = tradingDay.completed;
    } else {
      wetRevenueController.clear();
      foodRevenueController.clear();
      otherRevenueController.clear();
      labourCostController.clear();
      completed = false;
    }

    loading = false;
    notifyListeners();
  }

  Future<void> save() async {
    final tradingDate =
        HospitalityDayService.currentTradingDate();

    final tradingDay = TradingDay(
      id: HospitalityDayService.tradingDayId(),
      tradingDate: tradingDate,
      savedAt: DateTime.now(),
      wetRevenue: metrics.wetRevenue,
      foodRevenue: metrics.foodRevenue,
      otherRevenue: metrics.otherRevenue,
      labourCost: metrics.labourCost,
      completed: true,
    );

    await StorageService.saveTradingDay(tradingDay);

    completed = true;
    notifyListeners();
  }

  void _onChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    wetRevenueController.removeListener(_onChanged);
    foodRevenueController.removeListener(_onChanged);
    otherRevenueController.removeListener(_onChanged);
    labourCostController.removeListener(_onChanged);

    wetRevenueController.dispose();
    foodRevenueController.dispose();
    otherRevenueController.dispose();
    labourCostController.dispose();

    super.dispose();
  }
}