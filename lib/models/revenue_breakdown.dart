class RevenueBreakdown {
  final double wetRevenue;
  final double foodRevenue;
  final double otherRevenue;

  const RevenueBreakdown({
    required this.wetRevenue,
    required this.foodRevenue,
    required this.otherRevenue,
  });

  double get total =>
      wetRevenue + foodRevenue + otherRevenue;

  double get wetPercent =>
      total == 0 ? 0 : (wetRevenue / total) * 100;

  double get foodPercent =>
      total == 0 ? 0 : (foodRevenue / total) * 100;

  double get otherPercent =>
      total == 0 ? 0 : (otherRevenue / total) * 100;
}