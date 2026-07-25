import 'package:flutter/material.dart';

import '../../../models/refusal_entry.dart';
import '../controllers/refusal_form_controller.dart';

class RefusalCustomerCard extends StatefulWidget {
  final RefusalFormController controller;

  const RefusalCustomerCard({
    super.key,
    required this.controller,
  });

  @override
  State<RefusalCustomerCard> createState() =>
      _RefusalCustomerCardState();
}

class _RefusalCustomerCardState
    extends State<RefusalCustomerCard> {
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(
      text: widget.controller.form.description,
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
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
              'Customer Details',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 24),

            DropdownButtonFormField<RefusalGender>(
              initialValue: widget.controller.form.gender,
              decoration: const InputDecoration(
                labelText: 'Estimated Gender',
                border: OutlineInputBorder(),
              ),
              items: RefusalGender.values
                  .map(
                    (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  widget.controller.setGender(value);
                }
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<AgeCategory>(
              initialValue: widget.controller.form.ageCategory,
              decoration: const InputDecoration(
                labelText: 'Estimated Age',
                border: OutlineInputBorder(),
              ),
              items: AgeCategory.values
                  .map(
                    (age) => DropdownMenuItem(
                      value: age,
                      child: Text(age.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  widget.controller.setAgeCategory(value);
                }
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Customer Description',
                border: OutlineInputBorder(),
              ),
              onChanged: widget.controller.setDescription,
            ),
          ],
        ),
      ),
    );
  }
}