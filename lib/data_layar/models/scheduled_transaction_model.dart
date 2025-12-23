import '../../domain/entities/scheduled_transaction.dart';

class ScheduledTransactionModel extends ScheduledTransactionEntity {
  const ScheduledTransactionModel({
    required super.referenceNumber,
    required super.status,
    required super.type,
    required super.amount,
    required super.currency,
    required super.accountReference,
    required super.relatedAccountReference,
    required super.frequency,
    required super.dayOfWeek,
    required super.dayOfMonth,
    required super.timeOfDay,
    required super.timezone,
    required super.nextRunAt,
    required super.lastRunAt,
    required super.runsCount,
    required super.lastError,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ScheduledTransactionModel.fromJson(Map<String, dynamic> json) {
    return ScheduledTransactionModel(
      referenceNumber: json['reference_number'],
      status: json['status'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      accountReference: json['account_reference'],
      relatedAccountReference: json['related_account_reference'],
      frequency: json['frequency'],
      dayOfWeek: json['day_of_week'],
      dayOfMonth: json['day_of_month'],
      timeOfDay: json['time_of_day'],
      timezone: json['timezone'],
      nextRunAt: DateTime.parse(json['next_run_at']),
      lastRunAt:
      json['last_run_at'] != null ? DateTime.parse(json['last_run_at']) : null,
      runsCount: json['runs_count'],
      lastError: json['last_error'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static List<ScheduledTransactionModel> listFromJson(List list) {
    return list.map((e) => ScheduledTransactionModel.fromJson(e)).toList();
  }
}
