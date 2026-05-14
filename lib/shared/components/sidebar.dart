import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_design_system.dart';
import '../../core/state/global_providers.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCollapsed = ref.watch(sidebarControllerProvider);
    final currentPath = GoRouterState.of(context).uri.path;

    return AnimatedContainer(
      duration: AppDesign.durationNormal,
      curve: AppDesign.curveDefault,
      width: isCollapsed ? AppDesign.sidebarWidthCollapsed : AppDesign.sidebarWidthExpanded,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          _buildLogo(context, isCollapsed),
          const SizedBox(height: AppDesign.spaceXL),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceM),
              children: [
                _SidebarItem(
                  icon: Icons.dashboard_rounded,
                  label: 'Overview',
                  isSelected: currentPath == '/',
                  isCollapsed: isCollapsed,
                  onTap: () => context.go('/'),
                  semanticLabel: 'Navigate to Overview Dashboard',
                ),
                _SidebarItem(
                  icon: Icons.analytics_rounded,
                  label: 'Analytics',
                  isSelected: currentPath == '/analytics',
                  isCollapsed: isCollapsed,
                  onTap: () => context.go('/analytics'),
                  semanticLabel: 'Navigate to Business Analytics',
                ),
                _SidebarItem(
                  icon: Icons.people_rounded,
                  label: 'Employees',
                  isSelected: currentPath == '/employees',
                  isCollapsed: isCollapsed,
                  onTap: () => context.go('/employees'),
                  semanticLabel: 'Navigate to Employee Management',
                ),
                _SidebarItem(
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  isSelected: currentPath == '/settings',
                  isCollapsed: isCollapsed,
                  onTap: () => context.go('/settings'),
                  semanticLabel: 'Navigate to System Settings',
                ),
              ],
            ),
          ),
          _buildToggleButton(ref, isCollapsed),
          const SizedBox(height: AppDesign.spaceL),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? AppDesign.spaceM : AppDesign.spaceL,
        vertical: AppDesign.spaceL,
      ),
      child: InkWell(
        onTap: () => context.go('/'),
        borderRadius: BorderRadius.circular(AppDesign.radiusM),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDesign.spaceS),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppDesign.radiusM),
              ),
              child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
            ),
            if (!isCollapsed) ...[
              const SizedBox(width: AppDesign.spaceM),
              const Text(
                'NiftyNest',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: AppDesign.letterSpacingTight,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(WidgetRef ref, bool isCollapsed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceM),
      child: IconButton(
        onPressed: () => ref.read(sidebarControllerProvider.notifier).toggle(),
        icon: Icon(
          isCollapsed ? Icons.chevron_right_rounded : Icons.chevron_left_rounded,
          color: AppColors.textSecondary,
        ),
        tooltip: isCollapsed ? 'Expand Sidebar' : 'Collapse Sidebar',
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onTap;
  final String? semanticLabel;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isCollapsed,
    required this.onTap,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      selected: isSelected,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDesign.spaceS),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDesign.radiusM),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCollapsed ? 0 : AppDesign.spaceM,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.sidebarActive : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDesign.radiusM),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: AppDesign.spaceM),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
