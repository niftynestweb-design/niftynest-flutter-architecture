import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_design_system.dart';
import '../../features/notifications/application/notification_notifier.dart';

class NotificationPanel extends ConsumerWidget {
  const NotificationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationControllerProvider);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 320,
        constraints: const BoxConstraints(maxHeight: 480),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppDesign.radiusL),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDesign.spaceL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                  ),
                  TextButton(
                    onPressed: () => ref.read(notificationControllerProvider.notifier).markAllAsRead(),
                    child: const Text('Mark all as read', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            if (notifications.isEmpty)
              const Padding(
                padding: EdgeInsets.all(AppDesign.space2XL),
                child: Center(
                  child: Text(
                    'No notifications', 
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL, vertical: AppDesign.spaceS),
                      title: Text(
                        n.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold,
                          color: n.isRead ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        n.message,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      onTap: () => ref.read(notificationControllerProvider.notifier).markAsRead(n.id),
                      trailing: !n.isRead 
                          ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))
                          : null,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
