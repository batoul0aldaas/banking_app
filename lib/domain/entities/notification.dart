import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String referenceNumber;
  final String type;
  final String title;
  final String body;
  final NotificationDataEntity data;
  final bool read;
  final DateTime createdAt;

  const NotificationEntity({
    required this.referenceNumber,
    required this.type,
    required this.title,
    required this.body,
    required this.data,
    required this.read,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    referenceNumber,
    type,
    title,
    body,
    data,
    read,
    createdAt,
  ];
}

class NotificationDataEntity extends Equatable {
  final double amount;
  final int accountId;
  final double balanceAfter;
  final double balanceBefore;
  final String activityReference;

  const NotificationDataEntity({
    required this.amount,
    required this.accountId,
    required this.balanceAfter,
    required this.balanceBefore,
    required this.activityReference,
  });

  @override
  List<Object?> get props => [
    amount,
    accountId,
    balanceAfter,
    balanceBefore,
    activityReference,
  ];
}
