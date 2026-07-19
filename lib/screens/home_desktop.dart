import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/revenue_input_card.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  static const primaryColor = Color(0xFF163A70);

  final wetRevenueController = TextEditingController();
  final foodRevenueController = TextEditingController();
  final otherRevenueController = TextEditingController();
  final labourCostController = TextEditingController();

  bool completed = false;

  @override
  void dispose() {
    wetRevenueController.dispose();
    foodRevenueController.dispose();
    otherRevenueController.dispose();
    labourCostController.dispose();
    super.dispose();
  }

  void saveTradingDay() {
    setState(() => completed = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Trading figures saved successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          const Text(
            'Monday 20 July',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 35),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
              Expanded(
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
                      Icon(Icons.wb_sunny_rounded,
                          size: 48, color: Colors.orange),
                      SizedBox(height: 12),
                      Text(
                        "18°C",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text("Sunny"),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          DashboardCard(
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
                    Expanded(
                      child: RevenueInputCard(
                        title: "Wet Revenue",
                        controller: wetRevenueController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RevenueInputCard(
                        title: "Food Revenue",
                        controller: foodRevenueController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RevenueInputCard(
                        title: "Other Revenue",
                        controller: otherRevenueController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RevenueInputCard(
                        title: "Labour Cost",
                        controller: labourCostController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Icon(
                      completed
                          ? Icons.check_circle
                          : Icons.warning_amber_rounded,
                      color: completed ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      completed ? "Completed" : "Not Completed",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: saveTradingDay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: const Text("Save Trading Day"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
