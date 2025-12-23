import '../../domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({
    required super.id,
    required super.referenceNumber,
    required super.name,
    required super.type,
    required super.balance,
    required super.status,
    super.parentReference,
    super.metadata,
    super.children,
    super.createdAt,
    super.updatedAt,
  });

  static int _idFromReference(String ref) {
    final digits = RegExp(r'\d+').allMatches(ref).map((m) => m.group(0)).join();
    return int.tryParse(digits) ?? 0;
  }

  factory AccountModel.fromJson(
      Map<String, dynamic> json, {
        int? fallbackId,
      }) {
    final ref = (json['reference_number'] ?? '').toString();

    return AccountModel(
      referenceNumber: ref,
      id: (json['id'] is int) ? (json['id'] as int) : (fallbackId ?? _idFromReference(ref)),
      name: (json['name'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      balance: double.tryParse((json['balance'] ?? 0).toString()) ?? 0.0,
      status: (json['state'] ?? '').toString(),
      parentReference: json['parent_reference']?.toString(),
      metadata: (json['metadata'] is List) ? (json['metadata'] as List) : const [],
      children: (json['children'] is List)
          ? (json['children'] as List)
          .map((c) => AccountModel.fromJson(c as Map<String, dynamic>))
          .toList()
          : const [],
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
