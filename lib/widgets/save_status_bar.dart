import 'package:flutter/material.dart';

class SaveStatusBar extends StatelessWidget {
  final bool completed;
  final VoidCallback onSave;

  const SaveStatusBar({
    super.key,
    required this.completed,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          completed
              ? Icons.check_circle
              : Icons.warning_amber_rounded,
          color: completed ? Colors.green : Colors.orange,
        ),
        const SizedBox(width: 10),
        Text(
          completed ? "Completed" : "Not Completed",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 220,
          child: ElevatedButton(
            onPressed: onSave,
            child: const Text("Save Trading Day"),
          ),
        ),
      ],
    );
  }
}