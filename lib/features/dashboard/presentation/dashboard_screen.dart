import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_design_system.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../shared/mock/mock_data.dart';
import '../application/dashboard_notifier.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/timeframe_selector.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

    if (state.isLoading) {
      return const SingleChildScrollView(
        child: DashboardSkeleton(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppDesign.spaceXL),
          Responsive(
            mobile: _buildStatsGrid(context, crossAxisCount: 1),
            tablet: _buildStatsGrid(context, crossAxisCount: 2),
            desktop: _buildStatsGrid(context, crossAxisCount: 4),
          ),
          const SizedBox(height: AppDesign.spaceXL),
          _buildMainContent(context),
          const SizedBox(height: AppDesign.spaceXL),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Welcome back, Moaz. Here is what is happening today.',
              style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const TimeframeSelector(),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Responsive(
      mobile: Column(
        children: [
          _buildRecentActivity(),
          const SizedBox(height: AppDesign.spaceXL),
          _buildQuickActions(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildRecentActivity(),
          ),
          const SizedBox(width: AppDesign.spaceXL),
          Expanded(
            flex: 1,
            child: _buildQuickActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDesign.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDesign.spaceL),
            _buildActivityItem(
              'New employee onboarded',
              'Sarah Chen joined the design team',
              '2h ago',
              Icons.person_add_rounded,
            ),
            const Divider(height: AppDesign.spaceXL),
            _buildActivityItem(
              'System Update',
              'Architecture cleanup for Phase 4 completed',
              '5h ago',
              Icons.auto_awesome_rounded,
            ),
            const Divider(height: AppDesign.spaceXL),
            _buildActivityItem(
              'Revenue spike',
              'Daily target exceeded by 12%',
              'Yesterday',
              Icons.trending_up_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDesign.spaceS),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDesign.radiusM),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: AppDesign.spaceM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
        Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDesign.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDesign.spaceL),
            _buildActionItem('Hire Employee', Icons.add_rounded, () {}),
            const SizedBox(height: AppDesign.spaceM),
            _buildActionItem('Download Report', Icons.download_rounded, () {}),
            const SizedBox(height: AppDesign.spaceM),
            _buildActionItem('System Settings', Icons.settings_rounded, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDesign.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceM, vertical: AppDesign.spaceS),
        decoration: BoxDecoration(
          border: Border.all(color: AppDesign.opacityBorder > 0 ? AppColors.border : Colors.transparent),
          borderRadius: BorderRadius.circular(AppDesign.radiusM),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: AppDesign.spaceM),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return _buildActivityPanel();
  }

  Widget _buildStatsGrid(BuildContext context, {required int crossAxisCount}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: crossAxisCount == 1 ? 2.2 : (crossAxisCount == 2 ? 1.8 : 1.5),
      ),

      itemCount: mockDashboardStats.length,
      itemBuilder: (context, index) {
        final stat = mockDashboardStats[index];
        return DashboardCard(
          title: stat.title,
          value: stat.value,
          change: stat.change,
          isPositive: stat.isPositive,
          icon: _getIconForStat(index),
        );
      },
    );
  }

  Widget _buildActivityPanel() {
    return Card(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(AppDesign.spaceXL),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: Text(
                'Chart Area Placeholder',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  IconData _getIconForStat(int index) {
    switch (index) {
      case 0:
        return Icons.payments_rounded;
      case 1:
        return Icons.group_rounded;
      case 2:
        return Icons.trending_down_rounded;
      case 3:
        return Icons.timer_rounded;
      default:
        return Icons.bar_chart_rounded;
    }
  }
}

