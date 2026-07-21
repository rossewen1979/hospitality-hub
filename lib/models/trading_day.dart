class TradingDay {
  /// Unique ID for this hospitality trading day (yyyy-MM-dd)
  final String id;

  /// Hospitality trading day (05:00 - 04:59)
  final DateTime tradingDate;

  /// When this record was last saved
  final DateTime savedAt;

  final double wetRevenue;
  final double foodRevenue;
  final double otherRevenue;
  final double labourCost;

  final bool completed;

  const TradingDay({
    required this.id,
    required this.tradingDate,
    required this.savedAt,
    required this.wetRevenue,
    required this.foodRevenue,
    required this.otherRevenue,
    required this.labourCost,
    required this.completed,
  });

  double get totalRevenue =>
      wetRevenue + foodRevenue + otherRevenue;

  double get labourPercentage =>
      totalRevenue == 0
          ? 0
          : (labourCost / totalRevenue) * 100;

  double get wetPercentage =>
      totalRevenue == 0
          ? 0
          : (wetRevenue / totalRevenue) * 100;

  double get foodPercentage =>
      totalRevenue == 0
          ? 0
          : (foodRevenue / totalRevenue) * 100;

  double get otherPercentage =>
      totalRevenue == 0
          ? 0
          : (otherRevenue / totalRevenue) * 100;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tradingDate': tradingDate.toIso8601String(),
      'savedAt': savedAt.toIso8601String(),
      'wetRevenue': wetRevenue,
      'foodRevenue': foodRevenue,
      'otherRevenue': otherRevenue,
      'labourCost': labourCost,
      'completed': completed,
    };
  }

  factory TradingDay.fromJson(Map<String, dynamic> json) {
    return TradingDay(
      id: json['id'] ?? '',
      tradingDate: DateTime.parse(
        json['tradingDate'] ??
            DateTime.now().toIso8601String(),
      ),
      savedAt: DateTime.parse(
        json['savedAt'] ??
            DateTime.now().toIso8601String(),
      ),
      wetRevenue: (json['wetRevenue'] ?? 0).toDouble(),
      foodRevenue: (json['foodRevenue'] ?? 0).toDouble(),
      otherRevenue: (json['otherRevenue'] ?? 0).toDouble(),
      labourCost: (json['labourCost'] ?? 0).toDouble(),
      completed: json['completed'] ?? false,
    );
  }
}