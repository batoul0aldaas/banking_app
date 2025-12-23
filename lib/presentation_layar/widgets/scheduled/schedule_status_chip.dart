import 'package:flutter/material.dart';

class ScheduleStatusChip extends StatelessWidget {
  final String status;

  const ScheduleStatusChip({super.key, required this.status});

  Color _color() {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'paused':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Chip(
      label: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color.withOpacity(.15),
    );
  }
}
