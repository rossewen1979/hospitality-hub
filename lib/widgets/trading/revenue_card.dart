import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import '../dashboard_card.dart';

class RevenueCard extends StatelessWidget {
  final TradingDay tradingDay;

  const RevenueCard({
    super.key,
    required this.tradingDay,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        children: [
          const Text(
            'TOTAL REVENUE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '£${tradingDay.totalRevenue.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tradingDay.completed
                ? 'Trading day completed'
                : 'Trading day still in progress',
            style: TextStyle(
              color: tradingDay.completed
                  ? Colors.green
                  : Colors.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}