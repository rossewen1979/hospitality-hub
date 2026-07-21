import 'package:flutter/material.dart';

import '../services/hospitality_metrics.dart';
import 'dashboard_card.dart';
import 'kpi_tile.dart';

class SnapshotCard extends StatelessWidget {
  final HospitalityMetrics metrics;

  const SnapshotCard({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "This Week",
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
                value: '£${metrics.totalRevenue.toStringAsFixed(2)}',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Labour %',
                value: '${metrics.labourPercent.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Wet %',
                value: '${metrics.wetPercent.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Food %',
                value: '${metrics.foodPercent.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 12),
              KpiTile(
                title: 'Other %',
                value: '${metrics.otherPercent.toStringAsFixed(1)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}