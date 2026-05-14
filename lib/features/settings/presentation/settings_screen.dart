import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Appearance'),
          _buildSettingsCard(
            children: [
              _buildSettingTile(
                title: 'Dark Mode',
                subtitle: 'Enable dark theme for the entire application',
                trailing: Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (val) => ref.read(themeControllerProvider.notifier).toggleTheme(),
                  activeTrackColor: AppColors.primary,
                ),
              ),
              const Divider(height: 1),
              _buildSettingTile(
                title: 'Compact Mode',
                subtitle: 'Reduce density of lists and tables',
                trailing: Switch(
                  value: false,
                  onChanged: (val) {},
                  activeTrackColor: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Notifications'),
          _buildSettingsCard(
            children: [
              _buildSettingTile(
                title: 'Email Notifications',
                subtitle: 'Receive daily summary of activity via email',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeTrackColor: AppColors.primary,
                ),
              ),
              const Divider(height: 1),
              _buildSettingTile(
                title: 'System Alerts',
                subtitle: 'Get notified about important system events',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeTrackColor: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Security'),
          _buildSettingsCard(
            children: [
              _buildSettingTile(
                title: 'Two-Factor Authentication',
                subtitle: 'Add an extra layer of security to your account',
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
