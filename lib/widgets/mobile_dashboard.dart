import 'package:flutter/material.dart';

import '../controllers/trading_day_controller.dart';
import 'dashboard_card.dart';
import 'revenue_input_card.dart';
import 'save_status_bar.dart';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Yesterday's Trading",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Enter yesterday's figures below.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 24),

                RevenueInputCard(
                  title: "Wet Revenue",
                  controller: controller.wetRevenueController,
                ),

                const SizedBox(height: 16),

                RevenueInputCard(
                  title: "Food Revenue",
                  controller: controller.foodRevenueController,
                ),

                const SizedBox(height: 16),

                RevenueInputCard(
                  title: "Other Revenue",
                  controller: controller.otherRevenueController,
                ),

                const SizedBox(height: 16),

                RevenueInputCard(
                  title: "Labour Cost",
                  controller: controller.labourCostController,
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
      ),
    );
  }
}