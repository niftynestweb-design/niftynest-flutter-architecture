import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_design_system.dart';

enum ButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final String? semanticLabel;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = variant == ButtonVariant.primary;
    final bool isGhost = variant == ButtonVariant.ghost;

    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      enabled: !isLoading,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : (isGhost ? Colors.transparent : AppColors.card),
          foregroundColor: isPrimary ? Colors.white : AppColors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesign.spaceM,
            vertical: AppDesign.spaceM,
          ),
          minimumSize: const Size(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDesign.radiusM),
            side: isGhost ? BorderSide.none : const BorderSide(color: AppColors.border),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: AppDesign.spaceS),
                  ],
                  Text(
                    label,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.2),
                  ),
                ],
              ),
      ),
    );
  }
}
