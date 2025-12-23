import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/notifications/notifications_bloc.dart';
import '../../../bloc_layar/notifications/notifications_event.dart';
import '../../../bloc_layar/notifications/notifications_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/loading_indicator.dart';

class NotificationsCenterPage extends StatefulWidget {
  const NotificationsCenterPage({Key? key}) : super(key: key);

  @override
  State<NotificationsCenterPage> createState() =>
      _NotificationsCenterPageState();
}

class _NotificationsCenterPageState extends State<NotificationsCenterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    context.read<NotificationsBloc>().add(NotificationsLoadRequested());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _icon(String type) {
    switch (type) {
      case "balance_change":
        return Icons.account_balance_wallet_outlined;
      case "large_transaction":
        return Icons.warning_amber_rounded;
      default:
        return Icons.notifications;
    }
  }

  Color _color(String type) {
    switch (type) {
      case "balance_change":
        return Colors.blueAccent;
      case "large_transaction":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Notifications',
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const LoadingIndicator();
            }

            if (state is NotificationsLoadSuccess) {
              final items = state.notifications;

              if (items.isEmpty) {
                return const Center(child: Text("No notifications"));
              }

              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final n = items[i];

                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.92, end: 1).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _controller.forward(from: 0);

                        context.read<NotificationsBloc>().add(
                          MarkNotificationReadRequested(
                            n.referenceNumber,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: n.read
                              ? Colors.grey.shade200
                              : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: _color(n.type).withOpacity(0.15),
                              child: Icon(
                                _icon(n.type),
                                color: _color(n.type),
                              ),
                            ),
                            const SizedBox(width: 12),

                            /// المحتوى
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    n.title,
                                    style: TextStyle(
                                      fontWeight: n.read
                                          ? FontWeight.w500
                                          : FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    n.body,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        n.createdAt
                                            .toLocal()
                                            .toString()
                                            .split(' ')
                                            .first,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            if (!n.read)
                              Tooltip(
                                message: "Mark as read",
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    context.read<NotificationsBloc>().add(
                                      MarkNotificationReadRequested(
                                        n.referenceNumber,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      size: 22,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is NotificationsFailure) {
              return Center(child: Text("Error: ${state.error}"));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
