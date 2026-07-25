import 'package:flutter/foundation.dart';

import '../models/refusal_entry.dart';
import '../services/refusal_storage_service.dart';

class RefusalController extends ChangeNotifier {
  List<RefusalEntry> _refusals = [];

  List<RefusalEntry> get refusals => List.unmodifiable(_refusals);

  bool get hasRefusals => _refusals.isNotEmpty;

  int get refusalCount => _refusals.length;

  Future<void> loadRefusals() async {
    _refusals = await RefusalStorageService.loadAllRefusals();
    notifyListeners();
  }

  Future<String> generateRefusalNumber() async {
    return RefusalStorageService.nextRefusalNumber();
  }

  Future<void> saveRefusal(RefusalEntry refusal) async {
    _validate(refusal);

    await RefusalStorageService.saveRefusal(refusal);

    _refusals = await RefusalStorageService.loadAllRefusals();

    notifyListeners();
  }

  Future<RefusalEntry?> getRefusal(String id) async {
    return RefusalStorageService.loadRefusal(id);
  }

  Future<void> deleteRefusal(String id) async {
    await RefusalStorageService.deleteRefusal(id);

    _refusals = await RefusalStorageService.loadAllRefusals();

    notifyListeners();
  }

  void _validate(RefusalEntry refusal) {
    if (refusal.staffMember.trim().isEmpty) {
      throw Exception('Staff member is required.');
    }

    if (refusal.venue.trim().isEmpty) {
      throw Exception('Venue is required.');
    }

    if (refusal.description.trim().isEmpty) {
      throw Exception('Description is required.');
    }

    if (refusal.reasons.isEmpty) {
      throw Exception(
        'At least one refusal reason must be selected.',
      );
    }
  }
}