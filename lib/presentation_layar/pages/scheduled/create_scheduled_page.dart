import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_bloc.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_event.dart';
import '../../../bloc_layar/scheduled/scheduled_transaction_state.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/primary_button.dart';

class CreateScheduledPage extends StatefulWidget {
  const CreateScheduledPage({super.key});

  @override
  State<CreateScheduledPage> createState() => _CreateScheduledPageState();
}

class _CreateScheduledPageState extends State<CreateScheduledPage> {
  final _formKey = GlobalKey<FormState>();

  String _type = 'withdraw';
  String _frequency = 'monthly';
  String _timezone = 'UTC';

  int? _dayOfMonth;
  int? _dayOfWeek;
  TimeOfDay? _time;

  String? _accountRef;
  String? _relatedAccountRef;

  final _amountCtrl = TextEditingController();
  final _currencyCtrl = TextEditingController(text: 'USD');

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Create Schedule',
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
              const SnackBar(content: Text('Schedule created')),
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

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildAccountSelector(),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: const [
                    DropdownMenuItem(value: 'withdraw', child: Text('Withdraw')),
                    DropdownMenuItem(value: 'deposit', child: Text('Deposit')),
                    DropdownMenuItem(value: 'transfer', child: Text('Transfer')),
                  ],
                  onChanged: (v) => setState(() => _type = v!),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _amountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _currencyCtrl,
                  decoration: const InputDecoration(labelText: 'Currency'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
                ),

                const Divider(height: 32),

                DropdownButtonFormField<String>(
                  value: _frequency,
                  decoration: const InputDecoration(labelText: 'Frequency'),
                  items: const [
                    DropdownMenuItem(value: 'daily', child: Text('Daily')),
                    DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                    DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                  ],
                  onChanged: (v) => setState(() => _frequency = v!),
                ),

                if (_frequency == 'monthly')
                  TextFormField(
                    decoration:
                    const InputDecoration(labelText: 'Day of month (1-28)'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) =>
                    _dayOfMonth = int.tryParse(v),
                    validator: (v) {
                      if (_frequency != 'monthly') return null;
                      if (v == null || v.isEmpty) return 'Required';
                      final d = int.tryParse(v);
                      if (d == null || d < 1 || d > 28) {
                        return 'Invalid day';
                      }
                      return null;
                    },
                  ),

                if (_frequency == 'weekly')
                  TextFormField(
                    decoration:
                    const InputDecoration(labelText: 'Day of week (1-7)'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) =>
                    _dayOfWeek = int.tryParse(v),
                    validator: (v) {
                      if (_frequency != 'weekly') return null;
                      final d = int.tryParse(v ?? '');
                      if (d == null || d < 1 || d > 7) {
                        return 'Invalid day';
                      }
                      return null;
                    },
                  ),

                const SizedBox(height: 12),

                ListTile(
                  title: Text(
                    _time == null
                        ? 'Select time'
                        : _time!.format(context),
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final t = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (t != null) setState(() => _time = t);
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  initialValue: _timezone,
                  decoration: const InputDecoration(labelText: 'Timezone'),
                  onChanged: (v) => _timezone = v,
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  label: 'Create Schedule',
                  onPressed: _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) return const LoadingIndicator();
        if (state is AccountLoadSuccess) {
          return Column(
            children: [
              DropdownButtonFormField<String>(
                value: _accountRef,
                decoration:
                const InputDecoration(labelText: 'Account'),
                items: state.accounts
                    .map(
                      (a) => DropdownMenuItem(
                    value: a.referenceNumber,
                    child: Text(a.name),
                  ),
                )
                    .toList(),
                onChanged: (v) => setState(() => _accountRef = v),
                validator: (v) =>
                v == null ? 'Required' : null,
              ),
              if (_type == 'transfer')
                DropdownButtonFormField<String>(
                  value: _relatedAccountRef,
                  decoration: const InputDecoration(
                      labelText: 'Related Account'),
                  items: state.accounts
                      .map(
                        (a) => DropdownMenuItem(
                      value: a.referenceNumber,
                      child: Text(a.name),
                    ),
                  )
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _relatedAccountRef = v),
                  validator: (v) =>
                  _type == 'transfer' && v == null
                      ? 'Required'
                      : null,
                ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select time')),
      );
      return;
    }

    context.read<ScheduledTransactionBloc>().add(
      CreateScheduleRequested({
        "account_reference": _accountRef,
        "related_account_reference": _relatedAccountRef,
        "type": _type,
        "amount": double.parse(_amountCtrl.text),
        "currency": _currencyCtrl.text,
        "frequency": _frequency,
        "day_of_month": _dayOfMonth,
        "day_of_week": _dayOfWeek,
        "time_of_day":
        '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}',
        "timezone": _timezone,
      }),
    );
  }
}
