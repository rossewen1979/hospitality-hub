import 'package:flutter/material.dart';
import 'home_mobile.dart';
import 'home_desktop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const desktopBreakpoint = 900.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: screenWidth >= desktopBreakpoint
              ? const HomeDesktop()
              : const HomeMobile(),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        height: 72,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Trading',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}