import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_design_system.dart';
import '../../core/widgets/app_button.dart';

class OnboardingOverlay extends StatefulWidget {
  const OnboardingOverlay({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => const OnboardingOverlay(),
    );
  }

  @override
  State<OnboardingOverlay> createState() => _OnboardingOverlayState();
}

class _OnboardingOverlayState extends State<OnboardingOverlay> {
  int _currentStep = 0;

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      title: 'Command the Platform',
      description: 'Press ⌘K or Ctrl+K from anywhere to launch the Command Palette for lightning-fast navigation.',
      icon: Icons.keyboard_command_key_rounded,
    ),
    OnboardingStep(
      title: 'Enterprise Intelligence',
      description: 'Real-time analytics and personnel management designed for high-performance operational teams.',
      icon: Icons.analytics_rounded,
    ),
    OnboardingStep(
      title: 'Persistent Experience',
      description: 'Your theme and layout preferences are automatically saved across sessions for a seamless workflow.',
      icon: Icons.save_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(AppDesign.spaceXL),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDesign.radiusXL),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDesign.spaceL),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(step.icon, color: AppColors.primary, size: 40),
            ),
            const SizedBox(height: AppDesign.spaceXL),
            Text(
              step.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDesign.spaceM),
            Text(
              step.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: AppDesign.space2XL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(_steps.length, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: _currentStep == index ? AppColors.primary : AppColors.border,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                AppButton(
                  label: _currentStep == _steps.length - 1 ? 'Get Started' : 'Next',
                  onPressed: () {
                    if (_currentStep < _steps.length - 1) {
                      setState(() => _currentStep++);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingStep {
  final String title;
  final String description;
  final IconData icon;

  OnboardingStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}
