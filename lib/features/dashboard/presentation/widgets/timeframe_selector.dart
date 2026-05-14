import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/dashboard_notifier.dart';

class TimeframeSelector extends ConsumerWidget {
  const TimeframeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(context, ref, '7D', DashboardTimeframe.sevenDays, state.timeframe),
          _buildOption(context, ref, '30D', DashboardTimeframe.thirtyDays, state.timeframe),
          _buildOption(context, ref, '90D', DashboardTimeframe.ninetyDays, state.timeframe),
          _buildOption(context, ref, '1Y', DashboardTimeframe.oneYear, state.timeframe),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    WidgetRef ref,
    String label,
    DashboardTimeframe timeframe,
    DashboardTimeframe selected,
  ) {
    final bool isSelected = timeframe == selected;

    return GestureDetector(
      onTap: () => ref.read(dashboardControllerProvider.notifier).setTimeframe(timeframe),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sidebarActive : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
