import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../loading_indicator.dart';

class AccountDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String label;
  final FormFieldValidator<String>? validator;

  const AccountDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Account',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return const LoadingIndicator();
        }

        if (state is AccountLoadSuccess) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: label),
            value: value,
            items: state.accounts
                .map(
                  (account) => DropdownMenuItem(
                    value: account.referenceNumber,
                    child: Text(account.name),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            validator: validator ?? ((v) => v == null ? 'Required' : null),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}



