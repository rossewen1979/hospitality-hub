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
            height: 320,
            decoration: _decoration(),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final data = snapshot.data!;
        final total =
            data.wetRevenue + data.foodRevenue + data.otherRevenue;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: _decoration(),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        centerSpaceRadius: 60,
                        sectionsSpace: 4,
                        borderData: FlBorderData(show: false),
                        sections: [
                          PieChartSectionData(
                            value: data.wetRevenue,
                            color: Colors.blue,
                            radius: 55,
                            title:
                                '${data.wetPercent.toStringAsFixed(0)}%',
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            value: data.foodRevenue,
                            color: Colors.green,
                            radius: 55,
                            title:
                                '${data.foodPercent.toStringAsFixed(0)}%',
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            value: data.otherRevenue,
                            color: Colors.orange,
                            radius: 55,
                            title:
                                '${data.otherPercent.toStringAsFixed(0)}%',
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Revenue',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '£${total.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    _row(
                      Colors.blue,
                      'Wet',
                      data.wetPercent,
                      data.wetRevenue,
                    ),
                    const SizedBox(height: 18),
                    _row(
                      Colors.green,
                      'Food',
                      data.foodPercent,
                      data.foodRevenue,
                    ),
                    const SizedBox(height: 18),
                    _row(
                      Colors.orange,
                      'Other',
                      data.otherPercent,
                      data.otherRevenue,
                    ),
                    const Divider(height: 40),
                    FutureBuilder(
                      future:
                          WeeklyMetricsService.currentWeekMetrics(),
                      builder: (context, metricsSnapshot) {
                        if (!metricsSnapshot.hasData) {
                          return const SizedBox();
                        }

                        final metrics =
                            metricsSnapshot.data!;

                        return Row(
                          children: [
                            const Icon(
                              Icons.people,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'Labour',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '${metrics.labourPercent.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        );
                      },
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

  Widget _row(
    Color color,
    String title,
    double percent,
    double revenue,
  ) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          '${percent.toStringAsFixed(0)}%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 70,
          child: Text(
            '£${revenue.toStringAsFixed(0)}',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFFE6EAF0),
      ),
      boxShadow: const [
        BoxShadow(
          color:
              Color.fromRGBO(15, 23, 42, 0.05),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    );
  }
}