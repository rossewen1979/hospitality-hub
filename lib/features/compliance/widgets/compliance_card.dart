import 'package:flutter/material.dart';

class ComplianceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String lastEntry;
  final String buttonText;
  final VoidCallback onTap;

  const ComplianceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.lastEntry,
    required this.buttonText,
    required this.onTap,
  });

  @override
  State<ComplianceCard> createState() => _ComplianceCardState();
}

class _ComplianceCardState extends State<ComplianceCard> {
  bool hovering = false;

  Color get accentColor {
    switch (widget.title) {
      case 'Refusals Register':
        return const Color(0xFFE53935);

      case 'Accident Book':
        return const Color(0xFF43A047);

      case 'Incident Log':
        return const Color(0xFFFB8C00);

      default:
        return const Color(0xFF0F2D52);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          0,
          hovering ? -4 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFE6EAF0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .06),
              blurRadius: hovering ? 24 : 18,
              offset: Offset(0, hovering ? 12 : 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 180),
              scale: hovering ? 1.05 : 1,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: accentColor,
                  size: 32,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Last Entry',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              widget.lastEntry,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: widget.onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  elevation: hovering ? 4 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}