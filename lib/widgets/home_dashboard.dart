import 'package:flutter/material.dart';

import '../controllers/trading_day_controller.dart';
import 'header_card.dart';
import 'save_status_bar.dart';
import 'snapshot_card.dart';
import 'trading_entry_card.dart';
import 'weather_card.dart';

class HomeDashboard extends StatelessWidget {
  final TradingDayController controller;
  final VoidCallback onSave;

  const HomeDashboard({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final metrics = controller.metrics;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderCard(
            venueName: 'The Corner House',
            greeting: 'Good Morning, Ross',
            date: today,
          ),

          const SizedBox(height: 35),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SnapshotCard(
                  metrics: metrics,
                ),
              ),

              const SizedBox(width: 24),

              const Expanded(
                child: WeatherCard(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          TradingEntryCard(
            wetRevenueController: controller.wetRevenueController,
            foodRevenueController: controller.foodRevenueController,
            otherRevenueController: controller.otherRevenueController,
            labourCostController: controller.labourCostController,
          ),

          const SizedBox(height: 30),

          SaveStatusBar(
            completed: controller.completed,
            onSave: onSave,
          ),
        ],
      ),
    );
  }
}