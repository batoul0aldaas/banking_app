import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_bloc.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_event.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/scheduled/scheduled_tile.dart';
import '../../widgets/app_scaffold.dart';

class ScheduledListPage extends StatefulWidget {
  const ScheduledListPage({super.key});

  @override
  State<ScheduledListPage> createState() => _ScheduledListPageState();
}

class _ScheduledListPageState extends State<ScheduledListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduledTransactionBloc>().add(LoadSchedulesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Scheduled Transactions',
      showFab: true,
      fab: FloatingActionButton(
        onPressed: () async {
          final refreshed = await Navigator.pushNamed(
            context,
            AppRoutes.createScheduled,
          );

          if (refreshed == true) {
            context.read<ScheduledTransactionBloc>().add(
              LoadSchedulesRequested(),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ScheduledTransactionBloc, ScheduledTransactionState>(
        builder: (context, state) {
          if (state is ScheduledLoading) {
            return const LoadingIndicator();
          }
          if (state is ScheduledListSuccess) {
            if (state.schedules.isEmpty) {
              return const Center(child: Text('No schedules'));
            }
            return ListView.builder(
              itemCount: state.schedules.length,
              itemBuilder: (c, i) {
                final s = state.schedules[i];
                return ScheduledTile(
                  schedule: s,
                  onTap: () async {
                    final refreshed = await Navigator.pushNamed(
                      context,
                      AppRoutes.scheduledDetails,
                      arguments: s.referenceNumber,
                    );

                    if (refreshed == true) {
                      context.read<ScheduledTransactionBloc>().add(
                        LoadSchedulesRequested(),
                      );
                    }
                  },
                );
              },
            );
          }
          if (state is ScheduledFailure) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
