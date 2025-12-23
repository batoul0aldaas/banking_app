import '../../domain/entities/notification.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.referenceNumber,
    required super.type,
    required super.title,
    required super.body,
    required super.data,
    required super.read,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      referenceNumber: json['reference_number'],
      type: json['type'],
      title: json['title'],
      body: json['body'],
      data: NotificationDataModel.fromJson(json['data']),
      read: json['read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class NotificationDataModel extends NotificationDataEntity {
  const NotificationDataModel({
    required super.amount,
    required super.accountId,
    required super.balanceAfter,
    required super.balanceBefore,
    required super.activityReference,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      amount: double.parse(json['amount']),
      accountId: json['account_id'],
      balanceAfter: double.parse(json['balance_after']),
      balanceBefore: double.parse(json['balance_before']),
      activityReference: json['activity_reference'],
    );
  }
}
