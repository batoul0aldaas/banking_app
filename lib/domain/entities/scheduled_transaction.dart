import 'package:banking_app/domain/entities/schedule_status.dart';
import 'package:equatable/equatable.dart';

class ScheduledTransactionEntity extends Equatable {
  final String referenceNumber;
 // final String status;
  final ScheduleStatus status;
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

  const ScheduledTransactionEntity({
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

  @override
  List<Object?> get props => [
    referenceNumber,
    status,
    type,
    amount,
    currency,
    accountReference,
    relatedAccountReference,
    frequency,
    dayOfWeek,
    dayOfMonth,
    timeOfDay,
    timezone,
    nextRunAt,
    lastRunAt,
    runsCount,
    lastError,
    createdAt,
    updatedAt,
  ];
}
