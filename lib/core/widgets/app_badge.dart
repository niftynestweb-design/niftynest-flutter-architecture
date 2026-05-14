import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum BadgeStatus { success, warning, error, info, neutral }

class AppBadge extends StatelessWidget {
  final String label;
  final BadgeStatus status;

  const AppBadge({
    super.key,
    required this.label,
    this.status = BadgeStatus.neutral,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _getBackgroundColor().withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: _getBackgroundColor(),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (status) {
      case BadgeStatus.success:
        return AppColors.success;
      case BadgeStatus.warning:
        return AppColors.warning;
      case BadgeStatus.error:
        return AppColors.error;
      case BadgeStatus.info:
        return AppColors.info;
      case BadgeStatus.neutral:
        return AppColors.textSecondary;
    }
  }
}
