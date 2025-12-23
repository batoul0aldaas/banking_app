import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

abstract class NotificationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoadSuccess extends NotificationsState {
  final List<NotificationEntity> notifications;

  NotificationsLoadSuccess(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class NotificationsFailure extends NotificationsState {
  final String error;

  NotificationsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
