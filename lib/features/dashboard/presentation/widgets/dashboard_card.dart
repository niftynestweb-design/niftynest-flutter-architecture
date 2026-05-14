import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../core/widgets/counter_text.dart';
import '../../../../core/widgets/trend_indicator.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final num? numericValue = num.tryParse(value.replaceAll(RegExp(r'[^\d.]'), ''));
    final String prefix = value.startsWith('\$') ? '\$' : '';
    final double? changeValue = double.tryParse(change.replaceAll(RegExp(r'[^\d.]'), ''));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDesign.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
                Icon(
                  icon,
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: AppDesign.spaceM),
            numericValue != null
                ? CounterText(
                    value: numericValue,
                    prefix: prefix,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                : Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
            const SizedBox(height: AppDesign.spaceS),
            Row(
              children: [
                if (changeValue != null)
                  TrendIndicator(value: changeValue, isPositive: isPositive),
                const SizedBox(width: AppDesign.spaceS),
                Text(
                  'vs last period',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
