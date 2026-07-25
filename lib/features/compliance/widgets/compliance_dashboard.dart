import 'package:flutter/material.dart';

import 'compliance_section.dart';

class ComplianceDashboard extends StatelessWidget {
  const ComplianceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 28),
      child: ComplianceSection(),
    );
  }
}