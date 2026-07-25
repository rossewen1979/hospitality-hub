import 'package:flutter/material.dart';

import 'compliance_card.dart';

class ComplianceSection extends StatelessWidget {
  const ComplianceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compliance',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 250,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ComplianceCard(
                icon: Icons.block,
                title: 'Refusals Register',
                lastEntry: 'Never',
                onTap: () {},
              ),
              const SizedBox(width: 18),
              ComplianceCard(
                icon: Icons.medical_services_outlined,
                title: 'Accident Book',
                lastEntry: 'Never',
                onTap: () {},
              ),
              const SizedBox(width: 18),
              ComplianceCard(
                icon: Icons.warning_amber_rounded,
                title: 'Incident Log',
                lastEntry: 'Never',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}