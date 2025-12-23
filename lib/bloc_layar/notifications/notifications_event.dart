import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsLoadRequested extends NotificationsEvent {}

class MarkNotificationReadRequested extends NotificationsEvent {
  final String referenceNumber;

  MarkNotificationReadRequested(this.referenceNumber);

  @override
  List<Object?> get props => [referenceNumber];
}
