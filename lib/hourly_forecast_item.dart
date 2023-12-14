import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temparature;

  const HourlyForecastItem({
    super.key,
    required this.icon,
    required this.time,
    required this.temparature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(temparature),
          ],
        ),
      ),
    );
  }
}
