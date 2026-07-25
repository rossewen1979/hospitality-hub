import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import 'record_card.dart';
import 'records_empty.dart';

class RecordsList extends StatelessWidget {
  final List<TradingDay> tradingDays;
  final ValueChanged<TradingDay>? onRecordTap;

  const RecordsList({
    super.key,
    required this.tradingDays,
    this.onRecordTap,
  });

  @override
  Widget build(BuildContext context) {
    if (tradingDays.isEmpty) {
      return const RecordsEmpty(
        title: 'No trading records yet',
        message: 'Enter your first trading day to get started.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 20,
      ),
      itemCount: tradingDays.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final tradingDay = tradingDays[index];

        return RecordCard(
          tradingDay: tradingDay,
          onTap: () => onRecordTap?.call(tradingDay),
        );
      },
    );
  }
}