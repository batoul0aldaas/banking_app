import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../data_api/api_endpoints.dart';
import '../data_api/api_service.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({ApiService? api}) : api = api ?? ApiService();

  final ApiService api;

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  @override
  Future<User> login({required String email, required String password}) async {
    final data = await api.postMultipart(
      ApiEndpoints.login,
      fields: {
        "email": email,
        "password": password,
      },
    );

    final token = data["token"]?.toString();
    if (token == null || token.trim().isEmpty) {
      throw Exception("Token not found from API");
    }

    await saveToken(token);

    final profile = await api.get(ApiEndpoints.me, token: token);
    final user = UserModel.fromJson(profile["data"] as Map<String, dynamic>);
    return user;
  }

  @override
  Future<void> logout() async {
    final token = await getToken();
    if (token != null && token.trim().isNotEmpty) {
      try {
        await api.post(ApiEndpoints.logout, token: token);
      } catch (e) {
        print("Logout Error: $e");
      }
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString("auth_token") ?? "").trim().isNotEmpty;
  }
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await api.postMultipart(
      ApiEndpoints.register,
      fields: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    );
  }

  Future<User> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    final data = await api.postMultipart(
      ApiEndpoints.verifyRegisterOtp,
      fields: {
        "email": email,
        "otp": otp,
      },
    );

    final token = data["token"]?.toString();
    if (token == null || token.trim().isEmpty) {
      throw Exception("Token not found from API");
    }

    await saveToken(token);

    final userJson = (data["data"] as Map?)?.cast<String, dynamic>() ?? {};
    return UserModel.fromJson(userJson);
  }


  Future<void> forgotPassword({required String email}) async {
    await api.postMultipart(
      ApiEndpoints.forgotPassword,
      fields: {"email": email},
    );
  }
  Future<String> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    final data = await api.postMultipart(
      ApiEndpoints.verifyResetOtp,
      fields: {
        "email": email,
        "otp": otp,
      },
    );

    final resetToken = data["data"]?["reset_token"]?.toString();
    if (resetToken == null || resetToken.trim().isEmpty) {
      throw Exception("Reset token not found");
    }
    return resetToken;
  }

  Future<void> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    await api.postMultipart(
      ApiEndpoints.resetPassword,
      fields: {
        "email": email,
        "reset_token": resetToken,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    );
  }

  Future<void> refreshOtp({required String email, required String action}) async {
    await api.get("${ApiEndpoints.refreshOtp}?email=$email&action=$action");
  }
}
