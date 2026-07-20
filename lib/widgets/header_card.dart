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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 450,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          venueName,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          greeting,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${date.day}/${date.month}/${date.year}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}