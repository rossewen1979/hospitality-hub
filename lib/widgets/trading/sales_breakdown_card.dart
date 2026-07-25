import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import '../dashboard_card.dart';

class SalesBreakdownCard extends StatelessWidget {
  final TradingDay tradingDay;

  const SalesBreakdownCard({
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
            'Sales Breakdown',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          _SalesRow(
            icon: Icons.local_bar,
            title: 'Wet Sales',
            value: tradingDay.wetRevenue,
          ),

          const Divider(),

          _SalesRow(
            icon: Icons.restaurant,
            title: 'Food Sales',
            value: tradingDay.foodRevenue,
          ),

          const Divider(),

          _SalesRow(
            icon: Icons.shopping_bag,
            title: 'Other Sales',
            value: tradingDay.otherRevenue,
          ),
        ],
      ),
    );
  }
}

class _SalesRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final double value;

  const _SalesRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Icon(icon),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),

          Text(
            '£${value.toStringAsFixed(2)}',
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