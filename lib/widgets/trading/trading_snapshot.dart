import 'package:flutter/material.dart';

import '../../services/trading_metrics_service.dart';
import '../../services/hospitality_metrics.dart';

class TradingSnapshot extends StatelessWidget {
  const TradingSnapshot({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HospitalityMetrics>(
      future: TradingMetricsService.today(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final metrics = snapshot.data!;

        return Row(
          children: [
            Expanded(
              child: _KpiTile(
                title: 'Revenue',
                value: '£${metrics.totalRevenue.toStringAsFixed(2)}',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _KpiTile(
                title: 'Labour %',
                value:
                    '${metrics.labourPercent.toStringAsFixed(1)}%',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _KpiTile(
                title: 'Wet %',
                value:
                    '${metrics.wetPercent.toStringAsFixed(1)}%',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _KpiTile(
                title: 'Food %',
                value:
                    '${metrics.foodPercent.toStringAsFixed(1)}%',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _KpiTile(
                title: 'Other %',
                value:
                    '${metrics.otherPercent.toStringAsFixed(1)}%',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String title;
  final String value;

  const _KpiTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}