import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction_type.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class TransactionsLoadRequested extends TransactionEvent {}

class CreateTransactionRequested extends TransactionEvent {
  final TransactionType type;
  final String accountReference;
  final double amount;
  final String currency;
  final String? relatedAccountReference;

  const CreateTransactionRequested({
    required this.type,
    required this.accountReference,
    required this.amount,
    required this.currency,
    this.relatedAccountReference,
  });

  @override
  List<Object?> get props => [
    type,
    accountReference,
    amount,
    currency,
    relatedAccountReference,
  ];
}

class TransactionDetailsRequested extends TransactionEvent {
  final String referenceNumber;

  const TransactionDetailsRequested(this.referenceNumber);

  @override
  List<Object?> get props => [referenceNumber];
}
