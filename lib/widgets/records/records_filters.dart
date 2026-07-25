import 'package:flutter/material.dart';

enum RecordFilter {
  all,
  today,
 week,
  month,
  complete,
  incomplete,
}

class RecordsFilters extends StatelessWidget {
  final RecordFilter selectedFilter;
  final ValueChanged<RecordFilter> onFilterChanged;

  const RecordsFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildChip(
            context,
            RecordFilter.all,
            'All',
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            RecordFilter.today,
            'Today',
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            RecordFilter.week,
            'This Week',
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            RecordFilter.month,
            'This Month',
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            RecordFilter.complete,
            'Complete',
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            RecordFilter.incomplete,
            'Incomplete',
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    RecordFilter filter,
    String label,
  ) {
    return FilterChip(
      label: Text(label),
      selected: selectedFilter == filter,
      onSelected: (_) => onFilterChanged(filter),
    );
  }
}