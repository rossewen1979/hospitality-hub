import 'package:flutter/material.dart';

import '../controllers/trading_day_controller.dart';
import '../widgets/home_dashboard.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
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

    return HomeDashboard(
      controller: controller,
      onSave: _saveTradingDay,
    );
  }
}