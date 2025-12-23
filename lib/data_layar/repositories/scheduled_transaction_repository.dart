import '../../domain/entities/scheduled_transaction.dart';

abstract class ScheduledTransactionRepository {
  Future<List<ScheduledTransactionEntity>> getSchedules();

  Future<ScheduledTransactionEntity> getScheduleDetails(
      String referenceNumber,
      );

  Future<ScheduledTransactionEntity> createSchedule({
    required String accountReference,
    String? relatedAccountReference,
    required String type,
    required double amount,
    required String currency,
    required String frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    required String timeOfDay,
    required String timezone,
  });

  Future<ScheduledTransactionEntity> toggleScheduleStatus(
      String referenceNumber,
      );
}
