import 'package:flutter/material.dart';
import '../../../domain/entities/transaction.dart';

class TransactionTileFusion extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;

  const TransactionTileFusion({
    super.key,
    required this.transaction,
    this.onTap,
  });

  IconData _icon() {
    switch (transaction.type) {
      case 'deposit':
        return Icons.arrow_downward;
      case 'withdraw':
        return Icons.arrow_upward;
      case 'transfer':
        return Icons.swap_horiz;
      default:
        return Icons.monetization_on;
    }
  }

  Color _statusColor(BuildContext ctx) {
    switch (transaction.status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Theme.of(ctx).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final statusColor = _statusColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: statusColor.withOpacity(.12),
              child: Icon(_icon(), color: statusColor),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.type.toUpperCase()} • ${transaction.amount} ${transaction.currency}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Account: ${transaction.accountReference}'
                        '${transaction.relatedAccountReference != null ? ' → ${transaction.relatedAccountReference}' : ''}',
                    style: TextStyle(
                        color: cs.onSurface.withOpacity(.65)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ref: ${transaction.referenceNumber}',
                    style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withOpacity(.5)),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.processedAt
                      .toLocal()
                      .toString()
                      .split('.')
                      .first,
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withOpacity(.6)),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    transaction.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
