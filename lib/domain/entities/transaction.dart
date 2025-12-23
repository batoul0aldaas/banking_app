class TransactionEntity {
  final String referenceNumber;
  final String type;
  final String status;
  final double amount;
  final String currency;
  final String accountReference;
  final String? relatedAccountReference;
  final List<dynamic> metadata;
  final DateTime processedAt;
  final String? createdBy;
  final String? approvedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionEntity({
    required this.referenceNumber,
    required this.type,
    required this.status,
    required this.amount,
    required this.currency,
    required this.accountReference,
    this.relatedAccountReference,
    required this.metadata,
    required this.processedAt,
    this.createdBy,
    this.approvedBy,
    required this.createdAt,
    required this.updatedAt,
  });
}

/*import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String referenceNumber;
  final String type;
  final String status;
  final double amount;
  final String currency;
  final String accountReference;
  final String? relatedAccountReference;
  final List<dynamic> metadata;
  final DateTime processedAt;
  final String? createdBy;
  final String? approvedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionEntity({
    required this.referenceNumber,
    required this.type,
    required this.status,
    required this.amount,
    required this.currency,
    required this.accountReference,
    this.relatedAccountReference,
    required this.metadata,
    required this.processedAt,
    this.createdBy,
    this.approvedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    referenceNumber,
    type,
    status,
    amount,
    currency,
    accountReference,
    relatedAccountReference,
    metadata,
    processedAt,
    createdBy,
    approvedBy,
    createdAt,
    updatedAt,
  ];
}*/

