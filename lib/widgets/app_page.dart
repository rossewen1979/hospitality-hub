import 'package:flutter/material.dart';

import 'header_card.dart';

class AppPage extends StatelessWidget {
  final String venueName;
  final String greeting;
  final DateTime date;
  final Widget child;

  const AppPage({
    super.key,
    required this.venueName,
    required this.greeting,
    required this.date,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderCard(
                  venueName: venueName,
                  greeting: greeting,
                  date: date,
                ),

                const SizedBox(height: 24),

                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}