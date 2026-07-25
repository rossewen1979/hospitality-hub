import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/revenue_breakdown.dart';
import '../../services/weekly_metrics_service.dart';

class RevenueBreakdownCard extends StatelessWidget {
  const RevenueBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RevenueBreakdown>(
      future: WeeklyMetricsService.revenueBreakdown(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 260,
            decoration: _decoration(),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final data = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: _decoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Revenue Breakdown',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 45,
                          sectionsSpace: 3,
                          borderData: FlBorderData(show: false),
                          sections: [
                            PieChartSectionData(
                              value: data.wetRevenue,
                              color: Colors.blue,
                              title:
                                  '${data.wetPercent.toStringAsFixed(0)}%',
                              radius: 55,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: data.foodRevenue,
                              color: Colors.green,
                              title:
                                  '${data.foodPercent.toStringAsFixed(0)}%',
                              radius: 55,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: data.otherRevenue,
                              color: Colors.orange,
                              title:
                                  '${data.otherPercent.toStringAsFixed(0)}%',
                              radius: 55,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legend(
                            Colors.blue,
                            'Wet',
                            data.wetRevenue,
                          ),
                          const SizedBox(height: 14),
                          _legend(
                            Colors.green,
                            'Food',
                            data.foodRevenue,
                          ),
                          const SizedBox(height: 14),
                          _legend(
                            Colors.orange,
                            'Other',
                            data.otherRevenue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _legend(Color color, String label, double value) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          '£${value.toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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