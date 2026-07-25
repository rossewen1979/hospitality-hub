import 'package:flutter/material.dart';

import '../../models/trading_day.dart';
import '../../services/storage_service.dart';
import '../../widgets/app_page.dart';
import '../../widgets/records/records_filters.dart';
import '../../widgets/records/records_list.dart';
import '../../widgets/records/records_search.dart';
import '../trading_details_screen.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  bool _loading = true;

  final TextEditingController _searchController =
      TextEditingController();

  RecordFilter _selectedFilter = RecordFilter.all;

  List<TradingDay> _allTradingDays = [];
  List<TradingDay> _filteredTradingDays = [];

  @override
  void initState() {
    super.initState();
    _loadTradingDays();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTradingDays() async {
    setState(() => _loading = true);

    final tradingDays =
        await StorageService.loadAllTradingDays();

    tradingDays.sort(
      (a, b) => b.tradingDate.compareTo(a.tradingDate),
    );

    if (!mounted) return;

    _allTradingDays = tradingDays;
    _applyFilters();

    setState(() {
      _loading = false;
    });
  }

  void _applyFilters() {
    final search = _searchController.text.trim().toLowerCase();

    Iterable<TradingDay> records = _allTradingDays;

    final now = DateTime.now();

    switch (_selectedFilter) {
      case RecordFilter.all:
        break;

      case RecordFilter.today:
        records = records.where(
          (d) =>
              d.tradingDate.year == now.year &&
              d.tradingDate.month == now.month &&
              d.tradingDate.day == now.day,
        );
        break;

      case RecordFilter.week:
        final start =
            now.subtract(Duration(days: now.weekday - 1));
        final end = start.add(const Duration(days: 7));

        records = records.where(
          (d) =>
              !d.tradingDate.isBefore(start) &&
              d.tradingDate.isBefore(end),
        );
        break;

      case RecordFilter.month:
        records = records.where(
          (d) =>
              d.tradingDate.year == now.year &&
              d.tradingDate.month == now.month,
        );
        break;

      case RecordFilter.complete:
        records = records.where((d) => d.completed);
        break;

      case RecordFilter.incomplete:
        records = records.where((d) => !d.completed);
        break;
    }

    if (search.isNotEmpty) {
      records = records.where((day) {
        final date = day.tradingDate;

        final fullDate =
            "${date.day}/${date.month}/${date.year}"
                .toLowerCase();

        final shortDate =
            "${date.day} ${_monthName(date.month)} ${date.year}"
                .toLowerCase();

        final month =
            _monthName(date.month).toLowerCase();

        final weekday =
            _dayName(date.weekday).toLowerCase();

        return fullDate.contains(search) ||
            shortDate.contains(search) ||
            month.contains(search) ||
            weekday.contains(search) ||
            date.year.toString().contains(search);
      });
    }

    _filteredTradingDays = records.toList();
  }

  void _onSearchChanged(String value) {
    setState(_applyFilters);
  }

  void _onFilterChanged(RecordFilter filter) {
    setState(() {
      _selectedFilter = filter;
      _applyFilters();
    });
  }

  void _openRecord(TradingDay tradingDay) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TradingDetailsScreen(
          tradingDay: tradingDay,
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month];
  }

  String _dayName(int weekday) {
    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[weekday];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AppPage(
              venueName: 'Hospitality Hub',
              greeting: 'Trading History',
              date: DateTime.now(),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  RecordsSearch(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                  ),

                  const SizedBox(height: 16),

                  RecordsFilters(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: _onFilterChanged,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 700,
                    child: RefreshIndicator(
                      onRefresh: _loadTradingDays,
                      child: RecordsList(
                        tradingDays: _filteredTradingDays,
                        onRecordTap: _openRecord,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}