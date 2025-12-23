import 'package:flutter/material.dart';
import '../../../domain/strategies/transaction_strategy.dart';
import 'account_dropdown.dart';
import 'amount_field.dart';

class TransactionFormFields extends StatelessWidget {
  final TransactionStrategy strategy;
  final String? accountReference;
  final ValueChanged<String?> onAccountReferenceChanged;
  final String? relatedAccountReference;
  final ValueChanged<String?> onRelatedAccountReferenceChanged;
  final TextEditingController amountController;

  const TransactionFormFields({
    super.key,
    required this.strategy,
    required this.accountReference,
    required this.onAccountReferenceChanged,
    this.relatedAccountReference,
    required this.onRelatedAccountReferenceChanged,
    required this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountDropdown(
          value: accountReference,
          onChanged: onAccountReferenceChanged,
          label: strategy.requiresRelatedAccount() ? 'From Account' : 'Account',
        ),
        if (strategy.requiresRelatedAccount()) ...[
          const SizedBox(height: 12),
          AccountDropdown(
            value: relatedAccountReference,
            onChanged: onRelatedAccountReferenceChanged,
            label: 'To Account',
          ),
        ],
        const SizedBox(height: 12),
        AmountField(controller: amountController),
      ],
    );
  }
}



