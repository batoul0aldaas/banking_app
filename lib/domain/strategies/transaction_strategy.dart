import '../entities/transaction_type.dart';

/// Abstract strategy for handling different transaction types
abstract class TransactionStrategy {
  /// Returns the transaction type this strategy handles
  TransactionType get type;

  /// Returns the title/label for the transaction page
  String getTitle();

  /// Returns the submit button label
  String getSubmitLabel();

  /// Returns list of required field names for validation
  List<String> getRequiredFields();

  /// Builds the API payload for this transaction type
  Map<String, dynamic> buildPayload({
    required String accountReference,
    required double amount,
    required String currency,
    String? relatedAccountReference,
  });

  /// Returns whether this transaction type requires related account
  bool requiresRelatedAccount() => false;
}



