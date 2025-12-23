import '../../domain/entities/account_interest.dart';

class AccountInterestModel extends AccountInterest {
  AccountInterestModel({
    required super.accountReference,
    required super.type,
    required super.marketRate,
    required super.days,
    required super.interest,
  });

  factory AccountInterestModel.fromJson(Map<String, dynamic> json) {
    return AccountInterestModel(
      accountReference: json['account_reference'] ?? '',
      type: json['type'] ?? '',
      marketRate: (json['market_rate'] as num?)?.toDouble() ?? 0.0,
      days: json['days'] ?? 0,
      interest: (json['interest'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
