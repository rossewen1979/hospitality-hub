import 'package:flutter/material.dart';

class KpiTile extends StatelessWidget {
  final String title;
  final String value;

  const KpiTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 20,
            horizontal: isMobile ? 8 : 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}