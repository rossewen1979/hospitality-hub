import '../../../models/refusal_entry.dart';

class RefusalFormData {
  String refusalNumber = '';

  DateTime incidentDateTime = DateTime.now();

  String venue = '';

  String staffMember = '';

  RefusalGender gender = RefusalGender.unknown;

  AgeCategory ageCategory = AgeCategory.age18to24;

  List<RefusalReason> reasons = [];

  String description = '';

  bool managerNotified = false;

  bool policeCalled = false;

  bool get isValid {
    return venue.trim().isNotEmpty &&
        staffMember.trim().isNotEmpty &&
        description.trim().isNotEmpty &&
        reasons.isNotEmpty;
  }

  void toggleReason(
    RefusalReason reason,
  ) {
    if (reasons.contains(reason)) {
      reasons.remove(reason);
    } else {
      reasons.add(reason);
    }
  }

  void clear() {
    refusalNumber = '';
    incidentDateTime = DateTime.now();
    venue = '';
    staffMember = '';
    gender = RefusalGender.unknown;
    ageCategory = AgeCategory.age18to24;
    reasons.clear();
    description = '';
    managerNotified = false;
    policeCalled = false;
  }
}