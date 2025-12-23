import '../../domain/entities/scheduled_transaction.dart';
import '../../domain/state_pattern/schedule_status_factory.dart';

class ScheduledTransactionModel {
  final String referenceNumber;
  final String status;
  final String type;
  final double amount;
  final String currency;

  final String? accountReference;
  final String? relatedAccountReference;

  final String frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;
  final String timeOfDay;
  final String timezone;

  final DateTime nextRunAt;
  final DateTime? lastRunAt;
  final int runsCount;
  final String? lastError;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduledTransactionModel({
    required this.referenceNumber,
    required this.status,
    required this.type,
    required this.amount,
    required this.currency,
    required this.accountReference,
    required this.relatedAccountReference,
    required this.frequency,
    required this.dayOfWeek,
    required this.dayOfMonth,
    required this.timeOfDay,
    required this.timezone,
    required this.nextRunAt,
    required this.lastRunAt,
    required this.runsCount,
    required this.lastError,
    required this.createdAt,
    required this.updatedAt,
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
      lastRunAt: json['last_run_at'] != null ? DateTime.parse(json['last_run_at']) : null,
      runsCount: json['runs_count'],
      lastError: json['last_error'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static List<ScheduledTransactionModel> listFromJson(List list) {
    return list.map((e) => ScheduledTransactionModel.fromJson(e)).toList();
  }

  /*ScheduledTransactionEntity toEntity() {
    return ScheduledTransactionEntity(
      referenceNumber: referenceNumber,
      status: ScheduleStatusFactory.fromString(status),
      type: type,
      amount: amount,
      currency: currency,
      accountReference: accountReference,
      relatedAccountReference: relatedAccountReference,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      timeOfDay: timeOfDay,
      timezone: timezone,
      nextRunAt: nextRunAt,
      lastRunAt: lastRunAt,
      runsCount: runsCount,
      lastError: lastError,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }*/
}

