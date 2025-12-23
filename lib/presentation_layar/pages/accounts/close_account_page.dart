import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_event.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/loading_indicator.dart';

class CloseAccountPage extends StatefulWidget {
  final String accountReference;
  final String accountName;

  const CloseAccountPage({
    Key? key,
    required this.accountReference,
    required this.accountName,
  }) : super(key: key);

  @override
  State<CloseAccountPage> createState() => _CloseAccountPageState();
}

class _CloseAccountPageState extends State<CloseAccountPage> {
  bool _confirm = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppScaffold(
      title: 'Close Account',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account closed successfully')),
              );
              Navigator.pop(context);
            } else if (state is AccountFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account: ${widget.accountName}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: cs.onSurface),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Closing an account is irreversible. The account will be set to "closed" and will not accept transactions.',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _confirm,
                    onChanged: (v) => setState(() => _confirm = v ?? false),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('I confirm that I want to close this account.'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state is AccountLoading) return const LoadingIndicator();
                  return PrimaryButton(
                    label: 'Close Account',
                    onPressed: _confirm
                        ? () {
                      context.read<AccountBloc>().add(
                        AccountChangeStateRequested(
                          referenceNumber: widget.accountReference,
                          state: 'closed',
                        ),
                      );
                    }
                        : null,
                  );
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 14, offset: const Offset(0, 8))],
      ),
      child: child,
    );
  }
}
