import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/adapter_pattern/scheduled_transaction_adapter.dart';
import '../../domain/entities/scheduled_transaction.dart';
import '../../domain/adapter_pattern/scheduled_transaction_request.dart';
import '../data_api/api_endpoints.dart';
import '../data_api/api_service.dart';
import '../models/scheduled_response_model.dart';
import '../models/scheduled_transaction_model.dart';
import '../repositories/scheduled_transaction_repository.dart';

class ScheduledTransactionRepositoryImpl
    implements ScheduledTransactionRepository {
  final ApiService api;
  final ScheduledTransactionAdapter adapter;

  ScheduledTransactionRepositoryImpl({
    required this.api,
    ScheduledTransactionAdapter? adapter,
  }) : adapter = adapter ?? const DefaultScheduledTransactionAdapter();

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) throw "Token غير موجود";
    return token;
  }

  @override
  Future<List<ScheduledTransactionEntity>> getSchedules() async {
    final res =
    await api.get(ApiEndpoints.scheduledTransactions, token: await _getToken());

    final response = ScheduledResponseModel.fromJson(
      res,
          (json) => ScheduledTransactionModel.listFromJson(json),
    );

    return adapter.listFromModels(response.data);


  }

  @override
  Future<ScheduledTransactionEntity> getScheduleDetails(
      String referenceNumber) async {
    final res = await api.get(
      ApiEndpoints.scheduledTransactionDetails(referenceNumber),
      token: await _getToken(),
    );

    final response = ScheduledResponseModel.fromJson(
      res,
          (json) => ScheduledTransactionModel.fromJson(json),
    );

    return adapter.fromModel(response.data);
  }

  @override
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
  }) async {
    final request = ScheduledTransactionRequest(
      accountReference: accountReference,
      relatedAccountReference: relatedAccountReference,
      type: type,
      amount: amount,
      currency: currency,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      timeOfDay: timeOfDay,
      timezone: timezone,
    );

    final res = await api.postMultipart(
      ApiEndpoints.scheduledTransactions,
      fields: adapter.toCreatePayload(request),
      token: await _getToken(),
    );

    final response = ScheduledResponseModel.fromJson(
      res,
          (json) => ScheduledTransactionModel.fromJson(json),
    );

    return adapter.fromModel(response.data);
  }

  @override
  Future<ScheduledTransactionEntity> toggleScheduleStatus(
      String referenceNumber) async {
    final res = await api.postMultipart(
      ApiEndpoints.toggleScheduledTransaction(referenceNumber),
      fields: {
        "_method": "PATCH",
      },
      token: await _getToken(),
    );

    final response = ScheduledResponseModel.fromJson(
      res,
          (json) => ScheduledTransactionModel.fromJson(json),
    );

    return adapter.fromModel(response.data);
  }
}
