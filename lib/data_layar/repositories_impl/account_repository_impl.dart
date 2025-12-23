import 'package:shared_preferences/shared_preferences.dart';
import '../data_api/api_endpoints.dart';
import '../data_api/api_service.dart';
import '../repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final ApiService api;
  AccountRepositoryImpl({required this.api});

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) throw "Token غير موجود";
    return token;
  }

  @override
  Future<Map<String, dynamic>> getAccounts() async {
    return api.get(ApiEndpoints.myAccounts, token: await _getToken());
  }

  @override
  Future<Map<String, dynamic>> createAccount({
    required String name,
    required String type,
    String? parentReference,
  }) async {
    return api.postMultipart(
      ApiEndpoints.addAccount,
      fields: {
        "name": name,
        "type": type,
        if (parentReference != null) "parent_reference": parentReference,
      },
      token: await _getToken(),
    );
  }

  @override
  Future<Map<String, dynamic>> getAccountById(String referenceNumber) async {
    return api.get(ApiEndpoints.accountDetails(referenceNumber), token: await _getToken());
  }

  @override
  Future<Map<String, dynamic>> updateAccount(
      String referenceNumber, {
        String? name,
        String? type,
        String? parentReference,
        String? status,
      }) async {
    return api.postMultipart(
      ApiEndpoints.accountDetails(referenceNumber),
      fields: {
        if (name != null) "name": name,
        if (type != null) "type": type,
        if (parentReference != null) "parent_reference": parentReference,
        if (status != null) "state": status,
        "_method": "PUT",
      },
      token: await _getToken(),
    );
  }

  @override
  Future<Map<String, dynamic>> changeAccountState(String referenceNumber, String state) async {
    return api.postMultipart(
      ApiEndpoints.changeAccountState(referenceNumber),
      fields: {
        "state": state,
        "_method": "PATCH",
      },
      token: await _getToken(),
    );
  }

  @override
  Future<Map<String, dynamic>> getPortfolioBalance() async {
    return api.get(ApiEndpoints.portfolioBalance, token: await _getToken());
  }

  @override
  Future<Map<String, dynamic>> calculateInterest({
    required String referenceNumber,
    required int days,
  }) async {
    return api.get(
      ApiEndpoints.calculateInterest(referenceNumber),
      queryParameters: {'days': days},
      token: await _getToken(),
    );
  }

}
