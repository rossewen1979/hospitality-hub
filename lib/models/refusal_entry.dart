enum RefusalGender {
  male,
  female,
  other,
  unknown,
}

enum AgeCategory {
  under18,
  age18to24,
  age25to34,
  age35to44,
  age45Plus,
}

enum RefusalReason {
  noId,
  intoxicated,
  proxyPurchase,
  alreadyRefused,
  disorderlyBehaviour,
  suspectedDrugUse,
  violence,
  other,
}

class RefusalEntry {
  final String id;
  final DateTime incidentDateTime;

  final String venue;
  final String staffMember;

  final RefusalGender gender;
  final AgeCategory ageCategory;

  final List<RefusalReason> reasons;

  final String description;

  final bool policeCalled;
  final bool managerNotified;

  final DateTime createdAt;
  final String createdBy;

  final bool locked;

  const RefusalEntry({
    required this.id,
    required this.incidentDateTime,
    required this.venue,
    required this.staffMember,
    required this.gender,
    required this.ageCategory,
    required this.reasons,
    required this.description,
    required this.policeCalled,
    required this.managerNotified,
    required this.createdAt,
    required this.createdBy,
    this.locked = true,
  });

  RefusalEntry copyWith({
    String? id,
    DateTime? incidentDateTime,
    String? venue,
    String? staffMember,
    RefusalGender? gender,
    AgeCategory? ageCategory,
    List<RefusalReason>? reasons,
    String? description,
    bool? policeCalled,
    bool? managerNotified,
    DateTime? createdAt,
    String? createdBy,
    bool? locked,
  }) {
    return RefusalEntry(
      id: id ?? this.id,
      incidentDateTime: incidentDateTime ?? this.incidentDateTime,
      venue: venue ?? this.venue,
      staffMember: staffMember ?? this.staffMember,
      gender: gender ?? this.gender,
      ageCategory: ageCategory ?? this.ageCategory,
      reasons: reasons ?? this.reasons,
      description: description ?? this.description,
      policeCalled: policeCalled ?? this.policeCalled,
      managerNotified: managerNotified ?? this.managerNotified,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      locked: locked ?? this.locked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'incidentDateTime': incidentDateTime.toIso8601String(),
      'venue': venue,
      'staffMember': staffMember,
      'gender': gender.name,
      'ageCategory': ageCategory.name,
      'reasons': reasons.map((e) => e.name).toList(),
      'description': description,
      'policeCalled': policeCalled,
      'managerNotified': managerNotified,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'locked': locked,
    };
  }

  factory RefusalEntry.fromJson(Map<String, dynamic> json) {
    return RefusalEntry(
      id: json['id'] as String,
      incidentDateTime: DateTime.parse(json['incidentDateTime'] as String),
      venue: json['venue'] as String,
      staffMember: json['staffMember'] as String,
      gender: RefusalGender.values.firstWhere(
        (e) => e.name == json['gender'],
      ),
      ageCategory: AgeCategory.values.firstWhere(
        (e) => e.name == json['ageCategory'],
      ),
      reasons: (json['reasons'] as List)
          .map((e) => RefusalReason.values.firstWhere(
                (r) => r.name == e,
              ))
          .toList(),
      description: json['description'] as String,
      policeCalled: json['policeCalled'] as bool,
      managerNotified: json['managerNotified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String,
      locked: json['locked'] as bool? ?? true,
    );
  }

  @override
  String toString() => 'RefusalEntry(id: $id)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefusalEntry && other.id == id;

  @override
  int get hashCode => id.hashCode;
}