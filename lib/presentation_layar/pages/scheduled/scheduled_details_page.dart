import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_bloc.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_event.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/loading_indicator.dart';

class ScheduledDetailsPage extends StatelessWidget {
  const ScheduledDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reference =
    ModalRoute.of(context)!.settings.arguments as String;

    context.read<ScheduledTransactionBloc>().add(
      LoadScheduleDetailsRequested(reference),
    );

    return AppScaffold(
      title: 'Schedule Details',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context, true);
        },
      ),
      body: BlocConsumer<ScheduledTransactionBloc,
          ScheduledTransactionState>(
        listener: (context, state) {
          if (state is ScheduledOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Status updated')),
            );
            Navigator.pop(context, true);
          }

          if (state is ScheduledFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is ScheduledLoading) {
            return const LoadingIndicator();
          }

          if (state is ScheduledDetailsSuccess) {
            final s = state.schedule;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${s.type.toUpperCase()} • ${s.amount} ${s.currency}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text('Frequency: ${s.frequency}'),
                Text('Time: ${s.timeOfDay} (${s.timezone})'),
                Text(
                  'Next run: ${s.nextRunAt.toLocal()}',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<ScheduledTransactionBloc>().add(
                      ToggleScheduleStatusRequested(
                        s.referenceNumber,
                      ),
                    );
                  },
                  child: ElevatedButton(
                    onPressed: s.status.canToggle
                        ? () {
                      context.read<ScheduledTransactionBloc>().add(
                        ToggleScheduleStatusRequested(
                          s.referenceNumber,
                        ),
                      );
                    }
                        : null,
                    child: Text(s.status.actionLabel),
                  ),

                )
              ],
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
