import 'package:flutter/material.dart';

class ComplianceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String lastEntry;
  final VoidCallback onTap;

  const ComplianceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.lastEntry,
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
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(
              0,
              hovering ? -6 : 0,
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
                  color: const Color.fromRGBO(15, 23, 42, 0.10),
                  blurRadius: hovering ? 36 : 26,
                  spreadRadius: hovering ? 4 : 2,
                  offset: Offset(0, hovering ? 18 : 10),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 180),
                  scale: hovering ? 1.08 : 1,
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withValues(alpha: .12),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 36,
                      color: accentColor,
                    ),
                  ),
                ),

                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),

                Column(
                  children: [
                    const Text(
                      'Last Entry',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.lastEntry,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: hovering
                        ? accentColor.withValues(alpha: .08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: hovering ? 15 : 14,
                        ),
                        child: const Text('View'),
                      ),
                      const SizedBox(width: 6),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 180),
                        offset: hovering
                            ? const Offset(0.15, 0)
                            : Offset.zero,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}