import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationNotifier extends Notifier<List<AppNotification>> {
  @override
  List<AppNotification> build() {
    return [
      AppNotification(
        id: '1',
        title: 'New employee added',
        message: 'Moaz Aamir has been added to the Engineering team.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      AppNotification(
        id: '2',
        title: 'Monthly report generated',
        message: 'The performance report for April is now available.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      AppNotification(
        id: '3',
        title: 'Revenue Milestone',
        message: 'Daily revenue has increased by 14% compared to last week.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  void markAsRead(String id) {
    state = [
      for (final n in state)
        if (n.id == id) n.copyWith(isRead: true) else n
    ];
  }

  void markAllAsRead() {
    state = [for (final n in state) n.copyWith(isRead: true)];
  }

  int get unreadCount => state.where((n) => !n.isRead).length;
}

final notificationControllerProvider = NotifierProvider<NotificationNotifier, List<AppNotification>>(() {
  return NotificationNotifier();
});
