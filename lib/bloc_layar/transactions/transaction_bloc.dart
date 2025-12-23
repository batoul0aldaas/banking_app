import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layar/repositories/transaction_repository.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc({required this.repository})
      : super(TransactionInitial()) {
    on<TransactionsLoadRequested>(_onLoadTransactions);
    on<CreateTransactionRequested>(_onCreateTransaction);
    on<TransactionDetailsRequested>(_onLoadDetails);
  }

  Future<void> _onLoadTransactions(
      TransactionsLoadRequested event,
      Emitter<TransactionState> emit,
      ) async {
    emit(TransactionLoading());
    try {
      final transactions = await repository.getTransactions();
      emit(TransactionsLoadSuccess(transactions));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }

  Future<void> _onCreateTransaction(
      CreateTransactionRequested event,
      Emitter<TransactionState> emit,
      ) async {
    emit(TransactionLoading());
    try {
      final transaction = await repository.createTransaction(
        type: event.type,
        accountReference: event.accountReference,
        amount: event.amount,
        currency: event.currency,
        relatedAccountReference: event.relatedAccountReference,
      );

      emit(TransactionSuccess(transaction));

      add(TransactionsLoadRequested());
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }

  Future<void> _onLoadDetails(
      TransactionDetailsRequested event,
      Emitter<TransactionState> emit,
      ) async {
    emit(TransactionLoading());
    try {
      final transaction =
      await repository.getTransactionDetails(event.referenceNumber);
      emit(TransactionSuccess(transaction));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }
}
