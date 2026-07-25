import 'package:flutter/material.dart';

import '../../services/hospitality_metrics.dart';
import '../../services/weekly_metrics_service.dart';

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        WeeklyMetricsService.currentWeekMetrics(),
        WeeklyMetricsService.tradingDaysEnteredThisWeek(),
        WeeklyMetricsService.averageRevenueThisWeek(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 230,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final metrics = snapshot.data![0] as HospitalityMetrics;
        final days = snapshot.data![1] as int;
        final average = snapshot.data![2] as double;

        Widget stat(String title, String value) {
          return Expanded(
            child: Column(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE6EAF0),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(15, 23, 42, .05),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This Week',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  stat(
                    'Revenue',
                    '£${metrics.totalRevenue.toStringAsFixed(0)}',
                  ),
                  stat(
                    'Labour',
                    '${metrics.labourPercent.toStringAsFixed(1)}%',
                  ),
                  stat(
                    'Average',
                    '£${average.toStringAsFixed(0)}',
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  stat(
                    'Wet %',
                    '${metrics.wetPercent.toStringAsFixed(1)}%',
                  ),
                  stat(
                    'Food %',
                    '${metrics.foodPercent.toStringAsFixed(1)}%',
                  ),
                  stat(
                    'Days',
                    '$days',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}