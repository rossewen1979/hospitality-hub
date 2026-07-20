import 'package:flutter/material.dart';

import 'dashboard_card.dart';
import 'kpi_tile.dart';

class SnapshotCard extends StatelessWidget {
  final double wetRevenue;
  final double foodRevenue;
  final double otherRevenue;
  final double labourCost;

  const SnapshotCard({
    super.key,
    required this.wetRevenue,
    required this.foodRevenue,
    required this.otherRevenue,
    required this.labourCost,
  });

  @override
  Widget build(BuildContext context) {
    final totalRevenue =
        wetRevenue + foodRevenue + otherRevenue;

    final labourPercent = totalRevenue > 0
        ? (labourCost / totalRevenue) * 100
        : 0.0;

    final wetPercent = totalRevenue > 0
        ? (wetRevenue / totalRevenue) * 100
        : 0.0;

    final foodPercent = totalRevenue > 0
        ? (foodRevenue / totalRevenue) * 100
        : 0.0;

    final otherPercent = totalRevenue > 0
        ? (otherRevenue / totalRevenue) * 100
        : 0.0;

    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Snapshot",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              KpiTile(
                title: 'Revenue',
                value: '£${totalRevenue.toStringAsFixed(2)}',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Labour %',
                value: '${labourPercent.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Wet %',
                value: '${wetPercent.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Food %',
                value: '${foodPercent.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Other %',
                value: '${otherPercent.toStringAsFixed(1)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}