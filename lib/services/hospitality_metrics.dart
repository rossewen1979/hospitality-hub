class HospitalityMetrics {
  final double wetRevenue;
  final double foodRevenue;
  final double otherRevenue;
  final double labourCost;

  const HospitalityMetrics({
    required this.wetRevenue,
    required this.foodRevenue,
    required this.otherRevenue,
    required this.labourCost,
  });

  double get totalRevenue =>
      wetRevenue + foodRevenue + otherRevenue;

  double get labourPercent =>
      totalRevenue == 0
          ? 0
          : (labourCost / totalRevenue) * 100;

  double get wetPercent =>
      totalRevenue == 0
          ? 0
          : (wetRevenue / totalRevenue) * 100;

  double get foodPercent =>
      totalRevenue == 0
          ? 0
          : (foodRevenue / totalRevenue) * 100;

  double get otherPercent =>
      totalRevenue == 0
          ? 0
          : (otherRevenue / totalRevenue) * 100;
}