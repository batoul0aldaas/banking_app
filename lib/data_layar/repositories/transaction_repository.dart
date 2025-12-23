import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_type.dart';
import '../../domain/strategies/transaction_strategy.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getTransactions();

  Future<TransactionEntity> getTransactionDetails(String referenceNumber);

  Future<TransactionEntity> createTransaction({
    required TransactionType type,
    required String accountReference,
    required double amount,
    required String currency,
    String? relatedAccountReference,
  });
}
