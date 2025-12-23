import '../../data_layar/models/scheduled_transaction_model.dart';
import '../../domain/entities/scheduled_transaction.dart';
import '../state_pattern/schedule_status_factory.dart';

class ScheduledTransactionAdapter {
  static ScheduledTransactionEntity modelToEntity(ScheduledTransactionModel model) {
    return ScheduledTransactionEntity(
      referenceNumber: model.referenceNumber,
      status: ScheduleStatusFactory.fromString(model.status),
      type: model.type,
      amount: model.amount,
      currency: model.currency,
      accountReference: model.accountReference,
      relatedAccountReference: model.relatedAccountReference,
      frequency: model.frequency,
      dayOfWeek: model.dayOfWeek,
      dayOfMonth: model.dayOfMonth,
      timeOfDay: model.timeOfDay,
      timezone: model.timezone,
      nextRunAt: model.nextRunAt,
      lastRunAt: model.lastRunAt,
      runsCount: model.runsCount,
      lastError: model.lastError,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static List<ScheduledTransactionEntity> listModelToEntity(List<ScheduledTransactionModel> list) {
    return list.map((model) => modelToEntity(model)).toList();
  }
}
