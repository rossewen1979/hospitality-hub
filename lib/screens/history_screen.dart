import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/trading_day.dart';
import '../services/storage_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<TradingDay>> _history;

  @override
  void initState() {
    super.initState();
    _history = StorageService.loadAllTradingDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: FutureBuilder<List<TradingDay>>(
          future: _history,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Unable to load trading history.'),
              );
            }

            final history = snapshot.data ?? [];

            if (history.isEmpty) {
              return const Center(
                child: Text(
                  'No trading history yet.\n\nSave your first trading day to begin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            history.sort(
              (a, b) => b.tradingDate.compareTo(a.tradingDate),
            );

            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final day = history[index];

                final totalRevenue =
                    day.wetRevenue +
                    day.foodRevenue +
                    day.otherRevenue;

                final labourPercent = totalRevenue == 0
                    ? 0
                    : (day.labourCost / totalRevenue) * 100;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    title: Text(
                      DateFormat('EEEE d MMMM yyyy')
                          .format(day.tradingDate),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Revenue: £${totalRevenue.toStringAsFixed(2)}',
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Labour: ${labourPercent.toStringAsFixed(1)}%',
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Trading details coming next.',
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}