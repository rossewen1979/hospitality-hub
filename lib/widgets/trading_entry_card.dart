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
    return Expanded(
      child: RevenueInputCard(
        title: title,
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
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
          const SizedBox(height: 24),
          Row(
            children: [
              _buildRevenueField(
                "Wet Revenue",
                wetRevenueController,
              ),
              const SizedBox(width: 16),
              _buildRevenueField(
                "Food Revenue",
                foodRevenueController,
              ),
              const SizedBox(width: 16),
              _buildRevenueField(
                "Other Revenue",
                otherRevenueController,
              ),
              const SizedBox(width: 16),
              _buildRevenueField(
                "Labour Cost",
                labourCostController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}