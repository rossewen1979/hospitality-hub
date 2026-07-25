import 'package:flutter/material.dart';

import '../../../screens/records/refusals_home_screen.dart';
import 'compliance_card.dart';

class ComplianceSection extends StatelessWidget {
  const ComplianceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget refusalsCard() => ComplianceCard(
          icon: Icons.block,
          title: 'Refusals Register',
          lastEntry: 'Never',
          buttonText: 'Open Register',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const RefusalsHomeScreen(),
              ),
            );
          },
        );

    Widget accidentCard() => ComplianceCard(
          icon: Icons.medical_services_outlined,
          title: 'Accident Book',
          lastEntry: 'Never',
          buttonText: 'Open Book',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Accident Book coming soon'),
              ),
            );
          },
        );

    Widget incidentCard() => ComplianceCard(
          icon: Icons.warning_amber_rounded,
          title: 'Incident Log',
          lastEntry: 'Never',
          buttonText: 'Open Log',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incident Log coming soon'),
              ),
            );
          },
        );

    final headingStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );

    if (width >= 1100) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance',
            style: headingStyle,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 270,
            child: Row(
              children: [
                Expanded(child: refusalsCard()),
                const SizedBox(width: 18),
                Expanded(child: accidentCard()),
                const SizedBox(width: 18),
                Expanded(child: incidentCard()),
              ],
            ),
          ),
        ],
      );
    }

    if (width >= 700) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance',
            style: headingStyle,
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.15,
            children: [
              refusalsCard(),
              accidentCard(),
              incidentCard(),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compliance',
          style: headingStyle,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 235,
          child: refusalsCard(),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 235,
          child: accidentCard(),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 235,
          child: incidentCard(),
        ),
      ],
    );
  }
}