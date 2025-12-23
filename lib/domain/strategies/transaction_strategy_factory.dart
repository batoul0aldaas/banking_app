import '../entities/transaction_type.dart';
import 'transaction_strategy.dart';
import 'deposit_strategy.dart';
import 'withdraw_strategy.dart';
import 'transfer_strategy.dart';

/// Factory for creating transaction strategies based on transaction type
class TransactionStrategyFactory {
  /// Creates and returns the appropriate strategy for the given transaction type
  static TransactionStrategy createStrategy(TransactionType type) {
    switch (type) {
      case TransactionType.deposit:
        return DepositStrategy();
      case TransactionType.withdraw:
        return WithdrawStrategy();
      case TransactionType.transfer:
        return TransferStrategy();
    }
  }
}



