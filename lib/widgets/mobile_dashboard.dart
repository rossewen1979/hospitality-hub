import 'package:flutter/material.dart';

import '../controllers/trading_day_controller.dart';
import 'header_card.dart';
import 'save_status_bar.dart';
import 'snapshot_card.dart';
import 'trading_entry_card.dart';
import 'weather_card.dart';

class MobileDashboard extends StatelessWidget {
  final TradingDayController controller;
  final VoidCallback onSave;

  const MobileDashboard({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final metrics = controller.metrics;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderCard(
                venueName: 'The Corner House',
                greeting: 'Good Morning, Ross',
                date: today,
              ),

              const SizedBox(height: 24),

              SnapshotCard(
                metrics: metrics,
              ),

              const SizedBox(height: 20),

              const WeatherCard(),

              const SizedBox(height: 20),

              TradingEntryCard(
                wetRevenueController: controller.wetRevenueController,
                foodRevenueController: controller.foodRevenueController,
                otherRevenueController: controller.otherRevenueController,
                labourCostController: controller.labourCostController,
              ),

              const SizedBox(height: 24),

              SaveStatusBar(
                completed: controller.completed,
                onSave: onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}