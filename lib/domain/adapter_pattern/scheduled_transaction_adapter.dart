import '../../data_layar/models/scheduled_transaction_model.dart';
import '../../domain/entities/scheduled_transaction.dart';
import 'scheduled_transaction_request.dart';
import '../state_pattern/schedule_status_factory.dart';

abstract class ScheduledTransactionAdapter {
  ScheduledTransactionEntity fromModel(ScheduledTransactionModel model);

  List<ScheduledTransactionEntity> listFromModels(
    List<ScheduledTransactionModel> list,
  );

  Map<String, dynamic> toCreatePayload(ScheduledTransactionRequest request);
}

class DefaultScheduledTransactionAdapter
    implements ScheduledTransactionAdapter {
  const DefaultScheduledTransactionAdapter();

  @override
  ScheduledTransactionEntity fromModel(ScheduledTransactionModel model) {
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

  @override
  List<ScheduledTransactionEntity> listFromModels(
    List<ScheduledTransactionModel> list,
  ) {
    return list.map(fromModel).toList();
  }

  @override
  Map<String, dynamic> toCreatePayload(ScheduledTransactionRequest request) {
    return {
      "account_reference": request.accountReference,
      if (request.relatedAccountReference != null)
        "related_account_reference": request.relatedAccountReference,
      "type": request.type,
      "amount": request.amount,
      "currency": request.currency,
      "frequency": request.frequency,
      if (request.dayOfWeek != null) "day_of_week": request.dayOfWeek,
      if (request.dayOfMonth != null) "day_of_month": request.dayOfMonth,
      "time_of_day": request.timeOfDay,
      "timezone": request.timezone,
    };
  }
}
