import 'package:flutter/material.dart';

import '../../controllers/refusal_controller.dart';
import '../../models/refusal_entry.dart';
import '../../features/compliance/controllers/refusal_form_controller.dart';
import '../../features/compliance/widgets/refusal_actions_card.dart';
import '../../features/compliance/widgets/refusal_customer_card.dart';
import '../../features/compliance/widgets/refusal_header.dart';
import '../../features/compliance/widgets/refusal_incident_card.dart';
import '../../features/compliance/widgets/refusal_reason_card.dart';

class NewRefusalScreen extends StatefulWidget {
  const NewRefusalScreen({super.key});

  @override
  State<NewRefusalScreen> createState() =>
      _NewRefusalScreenState();
}

class _NewRefusalScreenState
    extends State<NewRefusalScreen> {
  late final RefusalFormController formController;
  late final RefusalController refusalController;

  String refusalNumber = 'Loading...';

  @override
  void initState() {
    super.initState();

    formController = RefusalFormController();
    refusalController = RefusalController();

    _loadRefusalNumber();
  }

  Future<void> _loadRefusalNumber() async {
    final number =
        await refusalController.generateRefusalNumber();

    if (!mounted) return;

    setState(() {
      refusalNumber = number;
      formController.form.refusalNumber = number;
    });
  }

  Future<void> _saveRefusal() async {
    if (!formController.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please complete all required fields.',
          ),
        ),
      );
      return;
    }

    final form = formController.form;

    final refusal = RefusalEntry(
      id: form.refusalNumber,
      incidentDateTime: form.incidentDateTime,
      venue: form.venue,
      staffMember: form.staffMember,
      gender: form.gender,
      ageCategory: form.ageCategory,
      reasons: form.reasons,
      description: form.description,
      policeCalled: form.policeCalled,
      managerNotified: form.managerNotified,
      createdAt: DateTime.now(),
      createdBy: form.staffMember,
    );

    await refusalController.saveRefusal(refusal);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Refusal saved successfully.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Refusal'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                RefusalHeader(
                  refusalNumber: refusalNumber,
                ),

                const SizedBox(height: 24),

                RefusalIncidentCard(
                  controller: formController,
                ),

                const SizedBox(height: 24),

                RefusalCustomerCard(
                  controller: formController,
                ),

                const SizedBox(height: 24),

                RefusalReasonCard(
                  controller: formController,
                ),

                const SizedBox(height: 24),

                RefusalActionsCard(
                  controller: formController,
                  onSave: _saveRefusal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}