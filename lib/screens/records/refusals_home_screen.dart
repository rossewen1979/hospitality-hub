import 'package:flutter/material.dart';

import 'new_refusal_screen.dart';
import 'refusal_history_screen.dart';

class RefusalsHomeScreen extends StatelessWidget {
  const RefusalsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refusals Register'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Licensing Compliance',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Record alcohol refusals and review previous entries.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionCard(
                          icon: Icons.block,
                          iconColor: const Color(0xFFE53935),
                          title: 'New Refusal',
                          description:
                              'Create a new refusals register entry.',
                          buttonText: 'Create',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const NewRefusalScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _ActionCard(
                          icon: Icons.history,
                          iconColor: const Color(0xFF1565C0),
                          title: 'Refusal History',
                          description:
                              'Browse and review previous refusals.',
                          buttonText: 'Open',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const RefusalHistoryScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: iconColor.withValues(alpha: 0.12),
              child: Icon(
                icon,
                color: iconColor,
                size: 38,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward),
                label: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}