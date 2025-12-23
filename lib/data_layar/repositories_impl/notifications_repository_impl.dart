import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/notification.dart';
import '../data_api/api_endpoints.dart';
import '../data_api/api_service.dart';
import '../models/notifications_response_model.dart';
import '../repositories/notifications_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService api;
  NotificationRepositoryImpl({required this.api});

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) throw "Token غير موجود";
    return token;
  }

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final response = await api.get(
      ApiEndpoints.notifications,
      token: await _getToken(),
    );

    final parsed = NotificationsResponseModel.fromJson(response);
    return parsed.data;
  }

  @override
  Future<void> markAsRead(String referenceNumber) async {
    await api.post(
      ApiEndpoints.markAsRead(referenceNumber),
      token: await _getToken(),
    );
  }
}
