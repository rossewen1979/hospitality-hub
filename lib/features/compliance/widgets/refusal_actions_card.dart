import 'package:flutter/material.dart';

import '../controllers/refusal_form_controller.dart';

class RefusalActionsCard extends StatelessWidget {
  final RefusalFormController controller;
  final VoidCallback onSave;

  const RefusalActionsCard({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions Taken',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              value: controller.form.managerNotified,
              title: const Text('Manager Notified'),
              secondary: const Icon(Icons.supervisor_account),
              onChanged: controller.setManagerNotified,
            ),

            SwitchListTile(
              value: controller.form.policeCalled,
              title: const Text('Police Called'),
              secondary: const Icon(Icons.local_police),
              onChanged: controller.setPoliceCalled,
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: FilledButton.icon(
                    onPressed: onSave,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Refusal'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}