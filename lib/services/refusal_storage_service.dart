import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/refusal_entry.dart';

class RefusalStorageService {
  static const _storageKey = 'refusal_register';

  static Future<List<RefusalEntry>> loadAllRefusals() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    final refusals = decoded
        .map((e) => RefusalEntry.fromJson(e))
        .toList();

    refusals.sort(
      (a, b) => b.incidentDateTime.compareTo(a.incidentDateTime),
    );

    return refusals;
  }

  static Future<void> saveRefusal(
    RefusalEntry refusal,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final refusals = await loadAllRefusals();

    refusals.removeWhere((e) => e.id == refusal.id);

    refusals.add(refusal);

    final jsonString = jsonEncode(
      refusals
          .map((e) => e.toJson())
          .toList(),
    );

    await prefs.setString(
      _storageKey,
      jsonString,
    );
  }

  static Future<RefusalEntry?> loadRefusal(
    String id,
  ) async {
    final refusals = await loadAllRefusals();

    try {
      return refusals.firstWhere(
        (e) => e.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<String> nextRefusalNumber() async {
    final refusals = await loadAllRefusals();

    if (refusals.isEmpty) {
      return 'REF-000001';
    }

    int highest = 0;

    for (final refusal in refusals) {
      final number = int.tryParse(
            refusal.id.replaceAll('REF-', ''),
          ) ??
          0;

      if (number > highest) {
        highest = number;
      }
    }

    highest++;

    return 'REF-${highest.toString().padLeft(6, '0')}';
  }

  static Future<void> deleteRefusal(
    String id,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final refusals = await loadAllRefusals();

    refusals.removeWhere(
      (e) => e.id == id,
    );

    final jsonString = jsonEncode(
      refusals
          .map((e) => e.toJson())
          .toList(),
    );

    await prefs.setString(
      _storageKey,
      jsonString,
    );
  }
}