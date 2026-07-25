import 'package:flutter/material.dart';

import '../../models/trading_day.dart';

class DetailsHeader extends StatelessWidget {
  final TradingDay tradingDay;

  const DetailsHeader({
    super.key,
    required this.tradingDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formattedDate(tradingDay.tradingDate),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tradingDay.completed
              ? 'Trading day completed'
              : 'Trading day incomplete',
          style: TextStyle(
            fontSize: 16,
            color: tradingDay.completed
                ? Colors.green
                : Colors.orange,
          ),
        ),
      ],
    );
  }

  String _formattedDate(DateTime date) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return '${days[date.weekday]} '
        '${date.day} '
        '${months[date.month]} '
        '${date.year}';
  }
}