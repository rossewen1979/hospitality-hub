import 'package:flutter/material.dart';

import '../widgets/app_page.dart';
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
                  child: _PlaceholderCard(
                    title: 'Revenue Breakdown',
                    subtitle:
                        'Live charts showing Wet, Food and Other sales.',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const _PlaceholderCard(
              title: 'Revenue Trends',
              subtitle:
                  'Daily and weekly revenue trends will appear here.',
              height: 320,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double height;

  const _PlaceholderCard({
    required this.title,
    required this.subtitle,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.05),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}