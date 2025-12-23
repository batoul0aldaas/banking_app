import 'package:flutter/material.dart';
import '../../../domain/entities/scheduled_transaction.dart';

class ScheduledTile extends StatelessWidget {
  final ScheduledTransactionEntity schedule;
  final VoidCallback? onTap;

  const ScheduledTile({
    super.key,
    required this.schedule,
    this.onTap,
  });

  Color _statusColor() {
    return schedule.status == 'active'
        ? Colors.green
        : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.schedule, color: _statusColor()),
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

      trailing: Chip(
        label: Text(schedule.status),
        backgroundColor: _statusColor().withOpacity(.15),
      ),
    );
  }
  String _format(DateTime d) {
    return '${d.day}/${d.month}/${d.year} ${d.hour}:${d.minute.toString().padLeft(2, '0')}';
  }

}
