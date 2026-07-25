import 'package:flutter/material.dart';

import '../widgets/app_page.dart';
import '../widgets/trading/revenue_breakdown_card.dart';
import '../widgets/trading/revenue_trend_card.dart';
import '../widgets/trading/trading_snapshot.dart';
import '../widgets/trading/weekly_summary_card.dart';

class TradingScreen extends StatelessWidget {
  const TradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: AppPage(
        venueName: 'Hospitality Hub',
        greeting: 'Trading Performance & Analysis',
        date: DateTime.now(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TradingSnapshot(),

            const SizedBox(height: 24),

            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: WeeklySummaryCard(),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 320,
                    child: RevenueBreakdownCard(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const SizedBox(
              height: 320,
              child: RevenueTrendCard(),
            ),
          ],
        ),
      ),
    );
  }
}