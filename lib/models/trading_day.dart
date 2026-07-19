class TradingDay {
  final double wetRevenue;
  final double foodRevenue;
  final double otherRevenue;
  final double labourCost;
  final bool completed;
  final DateTime date;

  const TradingDay({
    required this.wetRevenue,
    required this.foodRevenue,
    required this.otherRevenue,
    required this.labourCost,
    required this.completed,
    required this.date,
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
      'wetRevenue': wetRevenue,
      'foodRevenue': foodRevenue,
      'otherRevenue': otherRevenue,
      'labourCost': labourCost,
      'completed': completed,
      'date': date.toIso8601String(),
    };
  }

  factory TradingDay.fromJson(Map<String, dynamic> json) {
    return TradingDay(
      wetRevenue: (json['wetRevenue'] ?? 0).toDouble(),
      foodRevenue: (json['foodRevenue'] ?? 0).toDouble(),
      otherRevenue: (json['otherRevenue'] ?? 0).toDouble(),
      labourCost: (json['labourCost'] ?? 0).toDouble(),
      completed: json['completed'] ?? false,
      date: DateTime.parse(
        json['date'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}