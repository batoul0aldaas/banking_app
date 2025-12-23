abstract class AccountRepository {
  Future<Map<String, dynamic>> createAccount({
    required String name,
    required String type,
    String? parentReference,
  });

  Future<Map<String, dynamic>> getAccounts();

  Future<Map<String, dynamic>> getAccountById(String referenceNumber);

  Future<Map<String, dynamic>> updateAccount(
      String referenceNumber, {
        String? name,
        String? type,
        String? parentReference,
        String? status,
      });

  Future<Map<String, dynamic>> changeAccountState(String referenceNumber, String state);

  Future<Map<String, dynamic>> getPortfolioBalance();

  Future<Map<String, dynamic>> calculateInterest({
    required String referenceNumber,
    required int days,
  });
}
