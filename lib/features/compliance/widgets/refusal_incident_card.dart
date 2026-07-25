import 'package:flutter/material.dart';

import '../controllers/refusal_form_controller.dart';

class RefusalIncidentCard extends StatefulWidget {
  final RefusalFormController controller;

  const RefusalIncidentCard({
    super.key,
    required this.controller,
  });

  @override
  State<RefusalIncidentCard> createState() =>
      _RefusalIncidentCardState();
}

class _RefusalIncidentCardState
    extends State<RefusalIncidentCard> {
  late final TextEditingController venueController;
  late final TextEditingController staffController;

  @override
  void initState() {
    super.initState();

    venueController = TextEditingController(
      text: widget.controller.form.venue,
    );

    staffController = TextEditingController(
      text: widget.controller.form.staffMember,
    );
  }

  @override
  void dispose() {
    venueController.dispose();
    staffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final incident =
        widget.controller.form.incidentDateTime;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Incident Details',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: venueController,
              decoration: const InputDecoration(
                labelText: 'Venue',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
              onChanged:
                  widget.controller.setVenue,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: staffController,
              decoration: const InputDecoration(
                labelText: 'Staff Member',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              onChanged:
                  widget.controller.setStaffMember,
            ),

            const SizedBox(height: 24),

            Text(
              'Incident',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 10),

            Text(
              '${incident.day}/${incident.month}/${incident.year}  ${TimeOfDay.fromDateTime(incident).format(context)}',
            ),
          ],
        ),
      ),
    );
  }
}