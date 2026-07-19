import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF163A70);

    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = (screenWidth - 80 - 48) / 3;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: math.min(screenWidth * 0.42, 650),
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            'The Corner House',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Good Morning, Ross',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Monday 20 July',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 35),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: cardWidth,
                child: DashboardCard(
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
                      const SizedBox(height: 12),
                      const Text(
                        "Complete yesterday's figures to unlock today's insights.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Not Completed",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Complete Trading Day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 24),

              SizedBox(
                width: cardWidth,
                child: DashboardCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Today's Snapshot",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text("Sales"),
                      SizedBox(height: 10),
                      Text("Labour"),
                      SizedBox(height: 10),
                      Text("Gross Profit"),
                      SizedBox(height: 10),
                      Text("Customers"),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 24),

              SizedBox(
                width: cardWidth,
                child: DashboardCard(
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}