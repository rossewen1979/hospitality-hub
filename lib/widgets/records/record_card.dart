import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/trading_day.dart';

class RecordCard extends StatelessWidget {
  final TradingDay tradingDay;
  final VoidCallback? onTap;

  const RecordCard({
    super.key,
    required this.tradingDay,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'en_GB',
      symbol: '£',
    );

    final date = DateFormat(
      'EEE d MMM yyyy',
    ).format(tradingDay.tradingDate);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      date,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    tradingDay.completed
                        ? Icons.check_circle
                        : Icons.warning_amber_rounded,
                    color: tradingDay.completed
                        ? Colors.green
                        : Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              _buildRow(
                "Revenue",
                currency.format(
                  tradingDay.totalRevenue,
                ),
              ),

              _buildRow(
                "Labour",
                "${tradingDay.labourPercentage.toStringAsFixed(1)}%",
              ),

              const Divider(height: 28),

              _buildRow(
                "Wet",
                "${currency.format(tradingDay.wetRevenue)} (${tradingDay.wetPercentage.toStringAsFixed(0)}%)",
              ),

              _buildRow(
                "Food",
                "${currency.format(tradingDay.foodRevenue)} (${tradingDay.foodPercentage.toStringAsFixed(0)}%)",
              ),

              _buildRow(
                "Other",
                "${currency.format(tradingDay.otherRevenue)} (${tradingDay.otherPercentage.toStringAsFixed(0)}%)",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}