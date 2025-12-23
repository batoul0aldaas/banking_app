import 'transaction_strategy.dart';
import '../entities/transaction_type.dart';

class WithdrawStrategy implements TransactionStrategy {
  @override
  TransactionType get type => TransactionType.withdraw;

  @override
  String getTitle() => 'Withdraw';

  @override
  String getSubmitLabel() => 'Withdraw';

  @override
  List<String> getRequiredFields() => ['accountReference', 'amount'];

  @override
  Map<String, dynamic> buildPayload({
    required String accountReference,
    required double amount,
    required String currency,
    String? relatedAccountReference,
  }) {
    return {
      'type': type.value,
      'account_reference': accountReference,
      'amount': amount,
      'currency': currency,
    };
  }

  @override
  bool requiresRelatedAccount() => false;
}



