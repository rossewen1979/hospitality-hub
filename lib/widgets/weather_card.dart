import 'package:flutter/material.dart';

import 'dashboard_card.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Weather",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 18),
          Icon(
            Icons.wb_sunny_rounded,
            size: 48,
            color: Colors.orange,
          ),
          SizedBox(height: 12),
          Text(
            "18°C",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text("Sunny"),
        ],
      ),
    );
  }
}