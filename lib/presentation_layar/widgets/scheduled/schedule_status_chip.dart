import 'package:flutter/material.dart';
import '../../../domain/entities/schedule_status.dart';

class ScheduleStatusChip extends StatelessWidget {
  final ScheduleStatus status;

  const ScheduleStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        status.label,
        style: TextStyle(
          color: status.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: status.color.withOpacity(.15),
    );
  }
}
