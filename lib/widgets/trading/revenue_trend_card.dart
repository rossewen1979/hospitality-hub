import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import '../../services/storage_service.dart';

class RevenueTrendCard extends StatelessWidget {
  const RevenueTrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TradingDay>>(
      future: StorageService.loadAllTradingDays(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 320,
            decoration: _decoration(),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final days = List<TradingDay>.from(snapshot.data!)
          ..sort((a, b) => a.tradingDate.compareTo(b.tradingDate));

        final recent =
            days.length > 7 ? days.sublist(days.length - 7) : days;

        final spots = <FlSpot>[
          for (int i = 0; i < recent.length; i++)
            FlSpot(
              i.toDouble(),
              recent[i].totalRevenue,
            ),
        ];

        return Container(
          height: 320,
          padding: const EdgeInsets.all(24),
          decoration: _decoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Revenue Trend',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        barWidth: 4,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
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
    );
  }
}