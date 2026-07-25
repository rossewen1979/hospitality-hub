import 'package:flutter/material.dart';

class RefusalHistoryScreen extends StatelessWidget {
  const RefusalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refusal History'),
      ),
      body: const Center(
        child: Text(
          'Refusal History\nComing Next...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}