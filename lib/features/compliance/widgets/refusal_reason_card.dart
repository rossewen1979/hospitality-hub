import 'package:flutter/material.dart';

import '../../../models/refusal_entry.dart';
import '../controllers/refusal_form_controller.dart';

class RefusalReasonCard extends StatelessWidget {
  final RefusalFormController controller;

  const RefusalReasonCard({
    super.key,
    required this.controller,
  });

  Widget _reasonTile(
    RefusalReason reason,
    String title,
  ) {
    return Builder(
      builder: (context) {
        return CheckboxListTile(
          value: controller.hasReason(reason),
          title: Text(title),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          onChanged: (_) {
            controller.toggleReason(reason);
            (context as Element).markNeedsBuild();
          },
        );
      },
    );
  }

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
              'Reason For Refusal',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),

            _reasonTile(
              RefusalReason.noId,
              'No Valid ID',
            ),

            _reasonTile(
              RefusalReason.intoxicated,
              'Customer Intoxicated',
            ),

            _reasonTile(
              RefusalReason.proxyPurchase,
              'Suspected Proxy Purchase',
            ),

            _reasonTile(
              RefusalReason.alreadyRefused,
              'Previously Refused',
            ),

            _reasonTile(
              RefusalReason.disorderlyBehaviour,
              'Disorderly Behaviour',
            ),

            _reasonTile(
              RefusalReason.suspectedDrugUse,
              'Suspected Drug Use',
            ),

            _reasonTile(
              RefusalReason.violence,
              'Violent / Aggressive',
            ),

            _reasonTile(
              RefusalReason.other,
              'Other',
            ),
          ],
        ),
      ),
    );
  }
}