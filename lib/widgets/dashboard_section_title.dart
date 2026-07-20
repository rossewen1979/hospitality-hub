import 'package:flutter/material.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const DashboardSectionTitle({
    super.key,
    required this.title,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}