import 'package:flutter/material.dart';

import '../models/trading_day.dart';
import '../widgets/app_page.dart';
import '../widgets/trading/details_header.dart';
import '../widgets/trading/labour_card.dart';
import '../widgets/trading/revenue_card.dart';
import '../widgets/trading/sales_breakdown_card.dart';
import '../widgets/trading/status_card.dart';

class TradingDetailsScreen extends StatelessWidget {
  final TradingDay tradingDay;

  const TradingDetailsScreen({
    super.key,
    required this.tradingDay,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        venueName: 'Hospitality Hub',
        greeting: 'Trading Details',
        date: tradingDay.tradingDate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DetailsHeader(
              tradingDay: tradingDay,
            ),

            const SizedBox(height: 20),

            RevenueCard(
              tradingDay: tradingDay,
            ),

            const SizedBox(height: 16),

            SalesBreakdownCard(
              tradingDay: tradingDay,
            ),

            const SizedBox(height: 16),

            LabourCard(
              tradingDay: tradingDay,
            ),

            const SizedBox(height: 16),

            StatusCard(
              tradingDay: tradingDay,
            ),

            const SizedBox(height: 30),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.copy),
                  label: const Text('Duplicate'),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Export'),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}