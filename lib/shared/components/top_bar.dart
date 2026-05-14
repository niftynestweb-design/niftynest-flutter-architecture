import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_design_system.dart';
import '../../core/utils/responsive.dart';
import '../../features/notifications/application/notification_notifier.dart';
import 'command_palette.dart';
import 'notification_panel.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationControllerProvider);
    final unreadCount = ref.read(notificationControllerProvider.notifier).unreadCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL, vertical: AppDesign.spaceM),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withValues(alpha: AppDesign.opacityBorder)),
        ),
      ),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            Semantics(
              label: 'Open Sidebar',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          Semantics(
            header: true,
            child: const Text(
              'Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: AppDesign.letterSpacingTight,
              ),
            ),
          ),
          const Spacer(),
          _buildSearchButton(context),
          const SizedBox(width: AppDesign.spaceS),
          _buildNotificationButton(ref, unreadCount),
          const SizedBox(width: AppDesign.spaceM),
          _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Semantics(
      label: 'Search',
      button: true,
      child: IconButton(
        icon: const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
        onPressed: () => CommandPalette.show(context),
        tooltip: 'Search (⌘K)',
      ),
    );
  }

  Widget _buildNotificationButton(WidgetRef ref, int unreadCount) {
    return PopupMenuButton(
      offset: const Offset(0, 40),
      color: AppColors.card,
      elevation: 8,
      padding: EdgeInsets.zero,
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: const NotificationPanel(),
        ),
      ],
      child: Semantics(
        label: 'Notifications',
        button: true,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDesign.spaceS),
              child: const Icon(Icons.notifications_rounded, color: AppColors.textSecondary, size: 20),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                  child: Text(
                    '$unreadCount',
                    style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Semantics(
      label: 'User Profile',
      child: const CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.primary,
        child: Text(
          'MA',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
