import 'package:flutter/material.dart';

import '../controllers/trading_day_controller.dart';
import '../services/hospitality_metrics.dart';
import '../services/weekly_metrics_service.dart';
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
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1100;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
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

          if (isMobile)
            Column(
              children: [
                FutureBuilder<HospitalityMetrics>(
                  future: WeeklyMetricsService.currentWeekMetrics(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return SnapshotCard(
                      metrics: snapshot.data!,
                    );
                  },
                ),

                const SizedBox(height: 20),

                const WeatherCard(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder<HospitalityMetrics>(
                    future: WeeklyMetricsService.currentWeekMetrics(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SnapshotCard(
                        metrics: snapshot.data!,
                      );
                    },
                  ),
                ),

                SizedBox(width: isTablet ? 20 : 24),

                SizedBox(
                  width: isTablet ? 300 : 360,
                  child: const WeatherCard(),
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