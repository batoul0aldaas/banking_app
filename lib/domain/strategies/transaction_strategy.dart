import '../entities/transaction_type.dart';

abstract class TransactionStrategy {
  TransactionType get type;

  String getTitle();

  String getSubmitLabel();

  List<String> getRequiredFields();

  Map<String, dynamic> buildPayload({
    required String accountReference,
    required double amount,
    required String currency,
    String? relatedAccountReference,
  });

  bool requiresRelatedAccount() => false;
}



