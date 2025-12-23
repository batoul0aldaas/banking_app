import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/transactions/transaction_bloc.dart';
import '../../../bloc_layar/transactions/transaction_event.dart';
import '../../../bloc_layar/transactions/transaction_state.dart';
import '../../../domain/entities/transaction_type.dart';
import '../../../domain/strategies/transaction_strategy.dart';
import '../../../domain/strategies/transaction_strategy_factory.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/transactions/transaction_form_fields.dart';

class TransactionPage extends StatefulWidget {
  final TransactionType transactionType;

  const TransactionPage({
    super.key,
    required this.transactionType,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late final TransactionStrategy _strategy;
  final _form = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? _accountReference;
  String? _relatedAccountReference;

  @override
  void initState() {
    super.initState();
    _strategy = TransactionStrategyFactory.createStrategy(widget.transactionType);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_form.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    if (_accountReference == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an account')),
      );
      return;
    }

    if (_strategy.requiresRelatedAccount() &&
        (_relatedAccountReference == null ||
            _relatedAccountReference!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a related account')),
      );
      return;
    }

    context.read<TransactionBloc>().add(
          CreateTransactionRequested(
            type: widget.transactionType,
            accountReference: _accountReference!,
            amount: amount,
            currency: 'USD',
            relatedAccountReference: _relatedAccountReference,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: _strategy.getTitle(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TransactionFormFields(
                strategy: _strategy,
                accountReference: _accountReference,
                onAccountReferenceChanged: (value) {
                  setState(() {
                    _accountReference = value;
                  });
                },
                relatedAccountReference: _relatedAccountReference,
                onRelatedAccountReferenceChanged: (value) {
                  setState(() {
                    _relatedAccountReference = value;
                  });
                },
                amountController: _amountController,
              ),
              const SizedBox(height: 20),
              BlocConsumer<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state is TransactionSuccess) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${_strategy.getTitle()} completed successfully',
                        ),
                      ),
                    );
                  }
                  if (state is TransactionFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const LoadingIndicator();
                  }

                  return PrimaryButton(
                    label: _strategy.getSubmitLabel(),
                    onPressed: _handleSubmit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



