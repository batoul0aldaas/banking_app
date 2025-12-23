import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/transactions/transaction_bloc.dart';
import '../../../bloc_layar/transactions/transaction_event.dart';
import '../../../bloc_layar/transactions/transaction_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/loading_indicator.dart';

class TransactionDetailsPage extends StatefulWidget {
  const TransactionDetailsPage({super.key});

  @override
  State<TransactionDetailsPage> createState() =>
      _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  late final String referenceNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    referenceNumber =
    ModalRoute.of(context)!.settings.arguments as String;

    context.read<TransactionBloc>().add(
      TransactionDetailsRequested(referenceNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppScaffold(
      title: 'Transaction Details',
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const LoadingIndicator();
          }

          if (state is TransactionSuccess) {
            final tx = state.transaction;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(tx),
                      const Divider(height: 30),
                      _Row('Reference', tx.referenceNumber),
                      _Row('Type', tx.type.toUpperCase()),
                      _Row('Status', tx.status.toUpperCase(),
                          valueColor: _statusColor(tx.status, cs)),
                      _Row(
                        'Amount',
                        '${tx.amount} ${tx.currency}',
                        valueStyle: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      _Row('Account', tx.accountReference),
                      if (tx.relatedAccountReference != null)
                        _Row('Related Account',
                            tx.relatedAccountReference!),
                      _Row(
                        'Processed At',
                        tx.processedAt
                            .toLocal()
                            .toString()
                            .split('.')
                            .first,
                      ),
                      _Row(
                        'Created At',
                        tx.createdAt
                            .toLocal()
                            .toString()
                            .split('.')
                            .first,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is TransactionFailure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Color _statusColor(String status, ColorScheme cs) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return cs.primary;
    }
  }
}


class _Header extends StatelessWidget {
  final tx;

  const _Header(this.tx);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: cs.primary.withOpacity(.12),
          child: Icon(
            _icon(tx.type),
            color: cs.primary,
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tx.type.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tx.referenceNumber,
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurface.withOpacity(.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _icon(String type) {
    switch (type) {
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
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;
  final Color? valueColor;

  const _Row(
      this.label,
      this.value, {
        this.valueStyle,
        this.valueColor,
      });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                color: cs.onSurface.withOpacity(.6),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: valueStyle ??
                  TextStyle(
                    color: valueColor ?? cs.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
