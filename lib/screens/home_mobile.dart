import 'package:flutter/material.dart';

import '../controllers/trading_day_controller.dart';
import '../widgets/mobile_dashboard.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  late final TradingDayController controller;

  @override
  void initState() {
    super.initState();

    controller = TradingDayController();

    controller.addListener(_controllerChanged);

    controller.load();
  }

  void _controllerChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _saveTradingDay() async {
    await controller.save();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Trading figures saved successfully.',
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_controllerChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return MobileDashboard(
      controller: controller,
      onSave: _saveTradingDay,
    );
  }
}