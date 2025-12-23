import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionsLoadSuccess extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionsLoadSuccess(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionSuccess extends TransactionState {
  final TransactionEntity transaction;

  const TransactionSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionFailure extends TransactionState {
  final String error;

  const TransactionFailure(this.error);

  @override
  List<Object?> get props => [error];
}
