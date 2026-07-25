import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import '../dashboard_card.dart';

class StatusCard extends StatelessWidget {
  final TradingDay tradingDay;

  const StatusCard({
    super.key,
    required this.tradingDay,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Icon(
                tradingDay.completed
                    ? Icons.check_circle
                    : Icons.pending,
                color: tradingDay.completed
                    ? Colors.green
                    : Colors.orange,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  tradingDay.completed
                      ? 'Completed'
                      : 'Incomplete',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const Divider(height: 32),

          _StatusRow(
            label: 'Saved',
            value: _formatDateTime(tradingDay.savedAt),
          ),
        ],
      ),
    );
  }

  static String _formatDateTime(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/$year  $hour:$minute';
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatusRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}