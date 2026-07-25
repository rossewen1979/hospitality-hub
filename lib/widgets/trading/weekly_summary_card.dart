import 'package:flutter/material.dart';

import '../../models/trading_comparison.dart';
import '../../services/weekly_metrics_service.dart';

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TradingComparison>(
      future: WeeklyMetricsService.tradingComparison(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 320,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final comparison = snapshot.data!;

        return Container(
          height: 320,
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
                'Today\'s Trading',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              _valueRow(
                'Today',
                comparison.todayRevenue,
                Colors.black,
              ),

              const Divider(height: 28),

              _comparisonRow(
                title: 'Last Week',
                revenue: comparison.lastWeekRevenue,
                variance: comparison.revenueVsLastWeek,
                percent: comparison.revenueVsLastWeekPercent,
              ),

              const SizedBox(height: 18),

              _comparisonRow(
                title: 'Last Year',
                revenue: comparison.lastYearRevenue,
                variance: comparison.revenueVsLastYear,
                percent: comparison.revenueVsLastYearPercent,
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: _kpi(
                      'Labour',
                      comparison.today?.labourPercentage ?? 0,
                    ),
                  ),
                  Expanded(
                    child: _kpi(
                      'Wet',
                      comparison.today?.wetPercentage ?? 0,
                    ),
                  ),
                  Expanded(
                    child: _kpi(
                      'Food',
                      comparison.today?.foodPercentage ?? 0,
                    ),
                  ),
                  Expanded(
                    child: _kpi(
                      'Other',
                      comparison.today?.otherPercentage ?? 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _valueRow(
    String title,
    double value,
    Color colour,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          '£${value.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: colour,
          ),
        ),
      ],
    );
  }

  Widget _comparisonRow({
    required String title,
    required double revenue,
    required double variance,
    required double percent,
  }) {
    final positive = variance >= 0;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '£${revenue.toStringAsFixed(0)}',
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '${positive ? "▲" : "▼"} £${variance.abs().toStringAsFixed(0)} (${percent.abs().toStringAsFixed(1)}%)',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: positive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _kpi(
    String title,
    double value,
  ) {
    return Column(
      children: [
        Text(
          '${value.toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}