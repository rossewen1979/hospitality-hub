import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HospitalityHubApp());
}

class HospitalityHubApp extends StatelessWidget {
  const HospitalityHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospitality Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F2D52),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}