import 'package:banking_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc_layar/transactions/transaction_bloc.dart';
import '../../../bloc_layar/transactions/transaction_event.dart';
import '../../../bloc_layar/transactions/transaction_state.dart';
import '../../../domain/entities/transaction_type.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/transactions/transaction_tile.dart';

class TransactionsHistoryPage extends StatefulWidget {
  const TransactionsHistoryPage({super.key});

  @override
  State<TransactionsHistoryPage> createState() =>
      _TransactionsHistoryPageState();
}

class _TransactionsHistoryPageState extends State<TransactionsHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(TransactionsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Transactions',
      showFab: true,
      fab: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Deposit'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.deposit,arguments: TransactionType.deposit);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove),
                  title: Text('Withdraw'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.withdraw,arguments: TransactionType.withdraw);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.swap_horiz),
                  title: Text('Transfer'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.transfer,arguments: TransactionType.transfer,);
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const LoadingIndicator();
          }

          if (state is TransactionsLoadSuccess) {
            if (state.transactions.isEmpty) {
              return const Center(child: Text('No transactions'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.transactions.length,
              itemBuilder: (c, i) => TransactionTileFusion(
                transaction: state.transactions[i],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.transactionDetails,
                    arguments:
                    state.transactions[i].referenceNumber,
                  );
                },
              ),
            );
          }

          if (state is TransactionFailure) {
            return Center(child: Text(state.error));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
