import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../models/trading_day.dart';
import '../services/storage_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/revenue_input_card.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  static const primaryColor = Color(0xFF163A70);

  final TextEditingController wetRevenueController =
      TextEditingController();

  final TextEditingController foodRevenueController =
      TextEditingController();

  final TextEditingController otherRevenueController =
      TextEditingController();

  final TextEditingController labourCostController =
      TextEditingController();

  bool completed = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTradingDay();
  }

  Future<void> loadTradingDay() async {
    final tradingDay =
        await StorageService.loadTradingDay();

    if (tradingDay != null) {
      wetRevenueController.text =
          tradingDay.wetRevenue.toStringAsFixed(2);

      foodRevenueController.text =
          tradingDay.foodRevenue.toStringAsFixed(2);

      otherRevenueController.text =
          tradingDay.otherRevenue.toStringAsFixed(2);

      labourCostController.text =
          tradingDay.labourCost.toStringAsFixed(2);

      completed = tradingDay.completed;
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  double parseValue(
      TextEditingController controller) {
    return double.tryParse(
          controller.text.replaceAll(",", ""),
        ) ??
        0;
  }

  Future<void> saveTradingDay() async {
    final tradingDay = TradingDay(
      wetRevenue:
          parseValue(wetRevenueController),
      foodRevenue:
          parseValue(foodRevenueController),
      otherRevenue:
          parseValue(otherRevenueController),
      labourCost:
          parseValue(labourCostController),
      completed: true,
      date: DateTime.now(),
    );

    await StorageService.saveTradingDay(
      tradingDay,
    );

    if (!mounted) return;

    setState(() {
      completed = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Trading figures saved successfully.",
        ),
      ),
    );
  }

  @override
  void dispose() {
    wetRevenueController.dispose();
    foodRevenueController.dispose();
    otherRevenueController.dispose();
    labourCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final today = DateTime.now();

    return SingleChildScrollView(
      padding:
          const EdgeInsets.fromLTRB(24, 12, 24, 20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder:
                (context, constraints) {
              final logoWidth = math.min(
                constraints.maxWidth,
                720.0,
              );

              return Image.asset(
                "assets/images/logo.png",
                width: logoWidth,
                fit: BoxFit.contain,
              );
            },
          ),

          const SizedBox(height: 8),

          ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 460,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "The Corner House",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 2),

                const Text(
                  "Good Morning, Ross",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  "${today.day}/${today.month}/${today.year}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                DashboardCard(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [                      const Text(
                        "Yesterday's Trading",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Enter yesterday's figures below.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 24),

                      RevenueInputCard(
                        title: "Wet Revenue",
                        controller:
                            wetRevenueController,
                      ),

                      const SizedBox(height: 16),

                      RevenueInputCard(
                        title: "Food Revenue",
                        controller:
                            foodRevenueController,
                      ),

                      const SizedBox(height: 16),

                      RevenueInputCard(
                        title: "Other Revenue",
                        controller:
                            otherRevenueController,
                      ),

                      const SizedBox(height: 16),

                      RevenueInputCard(
                        title: "Labour Cost",
                        controller:
                            labourCostController,
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Icon(
                            completed
                                ? Icons.check_circle
                                : Icons
                                    .warning_amber_rounded,
                            color: completed
                                ? Colors.green
                                : Colors.orange,
                          ),

                          const SizedBox(width: 10),

                          Text(
                            completed
                                ? "Completed"
                                : "Not Completed",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              saveTradingDay,
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                primaryColor,
                            foregroundColor:
                                Colors.white,
                            elevation: 0,
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 18,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                14,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Save Trading Day",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}