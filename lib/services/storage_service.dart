import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/trading_day.dart';

class StorageService {
  static const String _tradingDaysKey = 'trading_days';

  static Future<void> saveTradingDay(TradingDay tradingDay) async {
    final prefs = await SharedPreferences.getInstance();

    final tradingDays = await loadTradingDays();

    tradingDays[tradingDay.id] = tradingDay;

    final jsonMap = tradingDays.map(
      (key, value) => MapEntry(
        key,
        value.toJson(),
      ),
    );

    await prefs.setString(
      _tradingDaysKey,
      jsonEncode(jsonMap),
    );
  }

  static Future<Map<String, TradingDay>> loadTradingDays() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_tradingDaysKey);

    if (json == null) {
      return {};
    }

    final decoded = jsonDecode(json) as Map<String, dynamic>;

    return decoded.map(
      (key, value) => MapEntry(
        key,
        TradingDay.fromJson(value),
      ),
    );
  }

  static Future<List<TradingDay>> loadAllTradingDays() async {
    final tradingDays = await loadTradingDays();

    final list = tradingDays.values.toList();

    list.sort(
      (a, b) => a.tradingDate.compareTo(b.tradingDate),
    );

    return list;
  }

  static Future<TradingDay?> loadTradingDay(String id) async {
    final tradingDays = await loadTradingDays();

    return tradingDays[id];
  }

  static Future<void> clearTradingDays() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tradingDaysKey);
  }
}