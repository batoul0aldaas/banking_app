
import '../../domain/entities/transaction.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.referenceNumber,
    required super.type,
    required super.status,
    required super.amount,
    required super.currency,
    required super.accountReference,
    super.relatedAccountReference,
    required super.metadata,
    required super.processedAt,
    super.createdBy,
    super.approvedBy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      referenceNumber: json['reference_number']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency']?.toString() ?? '',
      accountReference: json['account_reference']?.toString() ?? '',
      relatedAccountReference: json['related_account_reference']?.toString(), 
      metadata: json['metadata'] ?? [],
      processedAt: json['processed_at'] != null 
          ? DateTime.parse(json['processed_at'].toString())
          : DateTime.now(),
      createdBy: json['created_by']?.toString(),
      approvedBy: json['approved_by']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : DateTime.now(),
    );
  }
}
