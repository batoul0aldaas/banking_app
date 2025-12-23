import 'transaction_strategy.dart';
import '../entities/transaction_type.dart';

class TransferStrategy implements TransactionStrategy {
  @override
  TransactionType get type => TransactionType.transfer;

  @override
  String getTitle() => 'Transfer';

  @override
  String getSubmitLabel() => 'Transfer';

  @override
  List<String> getRequiredFields() => [
        'accountReference',
        'relatedAccountReference',
        'amount'
      ];

  @override
  Map<String, dynamic> buildPayload({
    required String accountReference,
    required double amount,
    required String currency,
    String? relatedAccountReference,
  }) {
    if (relatedAccountReference == null || relatedAccountReference.isEmpty) {
      throw ArgumentError(
        'relatedAccountReference is required for transfer transactions',
      );
    }

    return {
      'type': type.value,
      'account_reference': accountReference,
      'related_account_reference': relatedAccountReference,
      'amount': amount,
      'currency': currency,
    };
  }

  @override
  bool requiresRelatedAccount() => true;
}



