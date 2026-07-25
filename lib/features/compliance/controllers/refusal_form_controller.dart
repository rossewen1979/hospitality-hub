import 'package:flutter/foundation.dart';

import '../../../models/refusal_entry.dart';
import '../../../models/refusal_form_data.dart';

class RefusalFormController extends ChangeNotifier {
  final RefusalFormData form = RefusalFormData();

  void setVenue(String value) {
    form.venue = value;
    notifyListeners();
  }

  void setStaffMember(String value) {
    form.staffMember = value;
    notifyListeners();
  }

  void setDescription(String value) {
    form.description = value;
    notifyListeners();
  }

  void setGender(RefusalGender value) {
    form.gender = value;
    notifyListeners();
  }

  void setAgeCategory(AgeCategory value) {
    form.ageCategory = value;
    notifyListeners();
  }

  void setIncidentDateTime(DateTime value) {
    form.incidentDateTime = value;
    notifyListeners();
  }

  void toggleReason(RefusalReason reason) {
    form.toggleReason(reason);
    notifyListeners();
  }

  void setManagerNotified(bool value) {
    form.managerNotified = value;
    notifyListeners();
  }

  void setPoliceCalled(bool value) {
    form.policeCalled = value;
    notifyListeners();
  }

  bool hasReason(RefusalReason reason) {
    return form.reasons.contains(reason);
  }

  bool get isValid => form.isValid;

  void clear() {
    form.clear();
    notifyListeners();
  }
}