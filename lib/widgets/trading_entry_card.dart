import 'package:flutter/material.dart';

import 'dashboard_card.dart';
import 'revenue_input_card.dart';

class TradingEntryCard extends StatelessWidget {
  final TextEditingController wetRevenueController;
  final TextEditingController foodRevenueController;
  final TextEditingController otherRevenueController;
  final TextEditingController labourCostController;

  const TradingEntryCard({
    super.key,
    required this.wetRevenueController,
    required this.foodRevenueController,
    required this.otherRevenueController,
    required this.labourCostController,
  });

  Widget _buildRevenueField(
    String title,
    TextEditingController controller,
  ) {
    return RevenueInputCard(
      title: title,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter Today's Sales",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Figures for the current hospitality trading day (5:00am – 4:59am)",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          if (isMobile) ...[
            _buildRevenueField(
              "Wet Revenue",
              wetRevenueController,
            ),

            const SizedBox(height: 16),

            _buildRevenueField(
              "Food Revenue",
              foodRevenueController,
            ),

            const SizedBox(height: 16),

            _buildRevenueField(
              "Other Revenue",
              otherRevenueController,
            ),

            const SizedBox(height: 16),

            _buildRevenueField(
              "Labour Cost",
              labourCostController,
            ),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildRevenueField(
                    "Wet Revenue",
                    wetRevenueController,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _buildRevenueField(
                    "Food Revenue",
                    foodRevenueController,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _buildRevenueField(
                    "Other Revenue",
                    otherRevenueController,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _buildRevenueField(
                    "Labour Cost",
                    labourCostController,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}