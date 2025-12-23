import 'package:flutter/material.dart';
import '../../../domain/entities/scheduled_transaction.dart';
import '../scheduled/schedule_status_chip.dart';

class ScheduledTile extends StatelessWidget {
  final ScheduledTransactionEntity schedule;
  final VoidCallback? onTap;

  const ScheduledTile({
    super.key,
    required this.schedule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        Icons.schedule,
        color: schedule.status.color,
      ),
      title: Text(
        '${schedule.type.toUpperCase()} • ${schedule.amount} ${schedule.currency}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Next: ${_format(schedule.nextRunAt)}',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: ScheduleStatusChip(
        status: schedule.status,
      ),
    );
  }

  String _format(DateTime d) {
    return '${d.day}/${d.month}/${d.year} ${d.hour}:${d.minute.toString().padLeft(2, '0')}';
  }
}
