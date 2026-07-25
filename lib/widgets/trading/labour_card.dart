import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import '../dashboard_card.dart';

class LabourCard extends StatelessWidget {
  final TradingDay tradingDay;

  const LabourCard({
    super.key,
    required this.tradingDay,
  });

  @override
  Widget build(BuildContext context) {
    final labourPercent =
        tradingDay.labourPercentage.toStringAsFixed(1);

    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Labour',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _LabourRow(
            icon: Icons.payments_outlined,
            title: 'Labour Cost',
            value:
                '£${tradingDay.labourCost.toStringAsFixed(2)}',
          ),
          const Divider(),
          _LabourRow(
            icon: Icons.percent,
            title: 'Labour %',
            value: '$labourPercent%',
          ),
        ],
      ),
    );
  }
}

class _LabourRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _LabourRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}