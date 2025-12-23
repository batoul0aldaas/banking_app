import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_layar/accounts/account_bloc.dart';
import '../../bloc_layar/accounts/account_event.dart';
import '../../bloc_layar/accounts/account_state.dart';

class InterestDialog extends StatefulWidget {
  final String referenceNumber;
  final double balance;

  const InterestDialog({
    super.key,
    required this.referenceNumber,
    required this.balance,
  });

  @override
  State<InterestDialog> createState() => _InterestDialogState();
}

class _InterestDialogState extends State<InterestDialog> {
  final TextEditingController _daysController =
  TextEditingController(text: '1');

  void _calculateInterest() {
    final days = int.tryParse(_daysController.text) ?? 1;

    context.read<AccountBloc>().add(
      AccountCalculateInterestRequested(
        referenceNumber: widget.referenceNumber,
        days: days,
      ),
    );
  }

  void _closeDialog() {
    // ✅ لا تغيّر State الـ Bloc
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Calculate Interest"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _daysController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Number of Days",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          /// 👇 BlocBuilder محدود فقط بحالات الفائدة
          BlocBuilder<AccountBloc, AccountState>(
            buildWhen: (prev, curr) =>
            curr is AccountInterestLoading ||
                curr is AccountInterestSuccess ||
                curr is AccountInterestFailure,
            builder: (context, state) {
              if (state is AccountInterestLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                );
              }

              if (state is AccountInterestSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Interest: \$${state.interest.interest.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              if (state is AccountInterestFailure) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Error: ${state.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _closeDialog,
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: _calculateInterest,
          child: const Text("Calculate"),
        ),
      ],
    );
  }
}
