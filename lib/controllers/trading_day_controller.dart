import 'package:flutter/material.dart';

import '../models/trading_day.dart';
import '../services/storage_service.dart';

class TradingDayController extends ChangeNotifier {
  final wetRevenueController = TextEditingController();
  final foodRevenueController = TextEditingController();
  final otherRevenueController = TextEditingController();
  final labourCostController = TextEditingController();

  bool loading = true;
  bool completed = false;

  double get wetRevenue => _parse(wetRevenueController);

  double get foodRevenue => _parse(foodRevenueController);

  double get otherRevenue => _parse(otherRevenueController);

  double get labourCost => _parse(labourCostController);

  double get totalRevenue =>
      wetRevenue + foodRevenue + otherRevenue;

  double get labourPercent =>
      totalRevenue == 0 ? 0 : (labourCost / totalRevenue) * 100;

  Future<void> load() async {
    final tradingDay =
        await StorageService.loadTradingDay();

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
    }

    loading = false;
    notifyListeners();
  }

  Future<void> save() async {
    final tradingDay = TradingDay(
      wetRevenue: wetRevenue,
      foodRevenue: foodRevenue,
      otherRevenue: otherRevenue,
      labourCost: labourCost,
      completed: true,
      date: DateTime.now(),
    );

    await StorageService.saveTradingDay(
      tradingDay,
    );

    completed = true;

    notifyListeners();
  }

  double _parse(TextEditingController controller) {
    return double.tryParse(
          controller.text.replaceAll(',', ''),
        ) ??
        0;
  }

  @override
  void dispose() {
    wetRevenueController.dispose();
    foodRevenueController.dispose();
    otherRevenueController.dispose();
    labourCostController.dispose();
    super.dispose();
  }
}