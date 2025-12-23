import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layar/repositories/notifications_repository.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc
    extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository repository;

  NotificationsBloc({required this.repository})
      : super(NotificationsInitial()) {
    on<NotificationsLoadRequested>(_onLoad);
    on<MarkNotificationReadRequested>(_onMarkRead);
  }

  Future<void> _onLoad(
      NotificationsLoadRequested event,
      Emitter<NotificationsState> emit,
      ) async {
    emit(NotificationsLoading());
    try {
      final list = await repository.getNotifications();
      emit(NotificationsLoadSuccess(list));
    } catch (e) {
      emit(NotificationsFailure(e.toString()));
    }
  }

  Future<void> _onMarkRead(
      MarkNotificationReadRequested event,
      Emitter<NotificationsState> emit,
      ) async {
    try {
      await repository.markAsRead(event.referenceNumber);

      final list = await repository.getNotifications();
      emit(NotificationsLoadSuccess(list));
    } catch (e) {
      emit(NotificationsFailure(e.toString()));
    }
  }
}
