import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String venueName;
  final String greeting;
  final DateTime date;

  const HeaderCard({
    super.key,
    required this.venueName,
    required this.greeting,
    required this.date,
  });

  String get _formattedDate {
    const months = [
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

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 340,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          venueName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          greeting,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          _formattedDate,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 24),

        const Divider(
          thickness: 1,
          height: 1,
          color: Color(0xFFE5E7EB),
        ),
      ],
    );
  }
}