import 'notification_model.dart';

class NotificationsResponseModel {
  final int status;
  final List<NotificationModel> data;
  final String? message;

  NotificationsResponseModel({
    required this.status,
    required this.data,
    this.message,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationsResponseModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList(),
    );
  }
}
