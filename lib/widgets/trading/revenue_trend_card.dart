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

        if (recent.isEmpty) {
          return Container(
            height: 320,
            decoration: _decoration(),
            child: const Center(
              child: Text(
                'No trading data available.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        final spots = <FlSpot>[
          for (int i = 0; i < recent.length; i++)
            FlSpot(i.toDouble(), recent[i].totalRevenue),
        ];

        final revenues = recent.map((e) => e.totalRevenue).toList();

        final maxY = revenues.reduce((a, b) => a > b ? a : b);
        final minY = revenues.reduce((a, b) => a < b ? a : b);

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

              const SizedBox(height: 8),

              Text(
                'Last ${recent.length} Trading Days',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: LineChart(
                  LineChartData(
                    minY: minY * 0.9,
                    maxY: maxY * 1.1,

                    borderData: FlBorderData(show: false),

                    gridData: FlGridData(
                      show: true,
                      horizontalInterval:
                          ((maxY - minY) / 4).clamp(1, double.infinity),
                    ),

                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (spots) {
                          return spots.map((spot) {
                            final day =
                                recent[spot.x.toInt()];

                            return LineTooltipItem(
                              '${day.tradingDate.day}/${day.tradingDate.month}\n'
                              '£${day.totalRevenue.toStringAsFixed(2)}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),

                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 48,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '£${value.toInt()}',
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),

                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();

                            if (index < 0 ||
                                index >= recent.length) {
                              return const SizedBox();
                            }

                            final day = recent[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8),
                              child: Text(
                                '${day.tradingDate.day}/${day.tradingDate.month}',
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        barWidth: 4,
                        isStrokeCapRound: true,

                        dotData: FlDotData(
                          show: true,
                        ),

                        belowBarData: BarAreaData(
                          show: true,
                        ),
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
          color: Color.fromRGBO(
            15,
            23,
            42,
            0.05,
          ),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    );
  }
}