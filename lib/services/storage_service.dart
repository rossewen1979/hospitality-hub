import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/trading_day.dart';

class StorageService {
  static const String _tradingDayKey = 'trading_day';

  static Future<void> saveTradingDay(TradingDay tradingDay) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _tradingDayKey,
      jsonEncode(tradingDay.toJson()),
    );
  }

  static Future<TradingDay?> loadTradingDay() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_tradingDayKey);

    if (json == null) {
      return null;
    }

    return TradingDay.fromJson(
      jsonDecode(json),
    );
  }

  static Future<void> clearTradingDay() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tradingDayKey);
  }
}