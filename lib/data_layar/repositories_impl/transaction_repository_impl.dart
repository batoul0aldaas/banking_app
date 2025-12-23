import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_type.dart';
import '../../domain/strategies/transaction_strategy.dart';
import '../../domain/strategies/transaction_strategy_factory.dart';
import '../models/transaction_response_model.dart';
import '../models/transactions_list_response_model.dart';
import '../data_api/api_service.dart';
import '../data_api/api_endpoints.dart';
import '../repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final ApiService api;

  TransactionRepositoryImpl({required this.api});

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) throw "Token غير موجود";
    return token;
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final response = await api.get(
      ApiEndpoints.transactions,
      token: await _getToken(),
    );

    final model = TransactionsListResponseModel.fromJson(response);
    return model.data;
  }

  @override
  Future<TransactionEntity> getTransactionDetails(
      String referenceNumber) async {
    final response = await api.get(
      ApiEndpoints.transactionDetails(referenceNumber),
      token: await _getToken(),
    );

    final model = TransactionResponseModel.fromJson(response);
    return model.data;
  }

  @override
  Future<TransactionEntity> createTransaction({
    required TransactionType type,
    required String accountReference,
    required double amount,
    required String currency,
    String? relatedAccountReference,
  }) async {
    final strategy = TransactionStrategyFactory.createStrategy(type);
    final fields = strategy.buildPayload(
      accountReference: accountReference,
      amount: amount,
      currency: currency,
      relatedAccountReference: relatedAccountReference,
    );

    final response = await api.postMultipart(
      ApiEndpoints.transactions,
      fields: fields,
      token: await _getToken(),
    );

    final model = TransactionResponseModel.fromJson(response);
    return model.data;
  }

}
