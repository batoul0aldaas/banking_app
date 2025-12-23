import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_event.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/interest_dialog.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/primary_button.dart';
import '../../../core/routes/app_routes.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  String? _referenceNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_referenceNumber != null) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _referenceNumber = args;
      context.read<AccountBloc>().add(
        AccountDetailsRequested(referenceNumber: _referenceNumber!),
      );
    }
  }

  Color _statusColor(String s) {
    switch (s) {
      case 'active':
        return Colors.green;
      case 'frozen':
        return Colors.orange;
      case 'suspended':
        return Colors.red;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  String _money(double v) => v.toStringAsFixed(2);

  String _formatIso(String? iso) {
    if (iso == null || iso.trim().isEmpty) return '-';
    try {
      final dt = DateTime.parse(iso).toLocal();
      final y = dt.year.toString().padLeft(4, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final d = dt.day.toString().padLeft(2, '0');
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return "$y-$m-$d  $hh:$mm";
    } catch (_) {
      return iso;
    }
  }


  void _showInterestDialog(String ref, double balance) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AccountBloc>(),
        child: InterestDialog(
          referenceNumber: ref,
          balance: balance,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) return const LoadingIndicator();
        if (state is AccountFailure) {
          return AppScaffold(
            title: "Account Details",
            showFab: false,
            body: Center(child: Text("Error: ${state.error}")),
          );
        }
        if (state is AccountDetailsSuccess) {
          final a = state.account;
          final statusColor = _statusColor(a.status);

          return AppScaffold(
            title: "Account Details",
            showFab: false,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(icon: Icons.numbers, label: "Reference", value: a.referenceNumber),
                          _InfoRow(icon: Icons.badge_outlined, label: "Name", value: a.name),
                          _InfoRow(icon: Icons.category_outlined, label: "Type", value: a.type),
                          _InfoRow(
                            icon: Icons.account_balance_wallet_outlined,
                            label: "Balance",
                            value: "\$${_money(a.balance)}",
                            valueColor: Theme.of(context).colorScheme.primary,
                          ),
                          _InfoRow(
                            icon: Icons.shield_outlined,
                            label: "State",
                            value: a.status,
                            valueColor: statusColor,
                          ),
                          _InfoRow(icon: Icons.account_tree_outlined, label: "Parent Reference", value: a.parentReference ?? "-"),
                          _InfoRow(icon: Icons.event_available_outlined, label: "Created At", value: _formatIso(a.createdAt)),
                          _InfoRow(icon: Icons.update_outlined, label: "Updated At", value: _formatIso(a.updatedAt)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            label: "Edit Account",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.editAccount,
                                arguments: a,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PrimaryButton(
                            label: "Change State",
                            onPressed: () async {
                              String? newState = await showModalBottomSheet<String>(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                builder: (context) => _StateSelector(currentState: a.status),
                              );
                              if (newState != null && newState != a.status) {
                                context.read<AccountBloc>().add(
                                  AccountChangeStateRequested(
                                    referenceNumber: a.referenceNumber,
                                    state: newState,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: "Calculate Interest",
                      onPressed: () => _showInterestDialog(a.referenceNumber, a.balance),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}

class _StateSelector extends StatelessWidget {
  final String currentState;
  const _StateSelector({required this.currentState});

  @override
  Widget build(BuildContext context) {
    final states = ['active', 'frozen', 'suspended', 'closed'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: states.map((s) {
        return ListTile(
          title: Text(s.toUpperCase()),
          trailing: s == currentState ? const Icon(Icons.check, color: Colors.green) : null,
          onTap: () => Navigator.pop(context, s),
        );
      }).toList(),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.icon, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: cs.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(.6), fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: valueColor ?? cs.onSurface)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
