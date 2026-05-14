import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_design_system.dart';

class CommandPalette extends StatefulWidget {
  const CommandPalette({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => const CommandPalette(),
    );
  }

  @override
  State<CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<CommandPalette> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        Material(
          color: Colors.transparent,
          child: Container(
            width: 600,
            constraints: const BoxConstraints(maxHeight: 400),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDesign.radiusL),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSearchInput(),
                const Divider(height: 1),
                _buildResults(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.all(AppDesign.spaceM),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Search for actions, people, or settings...',
          hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.4)),
          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onSubmitted: (val) => Navigator.pop(context),
      ),
    );
  }

  Widget _buildResults() {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: AppDesign.spaceS),
        children: [
          _buildResultGroup('NAVIGATION'),
          _buildResultItem('Go to Overview', Icons.dashboard_rounded, 'Shift + G + O'),
          _buildResultItem('Go to Analytics', Icons.analytics_rounded, 'Shift + G + A'),
          _buildResultItem('Go to Employees', Icons.people_rounded, 'Shift + G + E'),
          const SizedBox(height: AppDesign.spaceS),
          _buildResultGroup('ACTIONS'),
          _buildResultItem('Hire New Employee', Icons.person_add_rounded, '⌘ + N'),
          _buildResultItem('Export Monthly Report', Icons.download_rounded, '⌘ + E'),
          _buildResultItem('Toggle Theme', Icons.contrast_rounded, '⌘ + T'),
        ],
      ),
    );
  }

  Widget _buildResultGroup(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL, vertical: AppDesign.spaceS),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary.withValues(alpha: 0.5),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildResultItem(String title, IconData icon, String shortcut) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL),
      leading: Icon(icon, size: 18, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.border.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          shortcut,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary.withValues(alpha: 0.8),
            fontFamily: 'monospace',
          ),
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL, vertical: AppDesign.spaceS),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppDesign.radiusL),
          bottomRight: Radius.circular(AppDesign.radiusL),
        ),
      ),
      child: Row(
        children: [
          _buildFooterHint('↑↓', 'to navigate'),
          const SizedBox(width: AppDesign.spaceM),
          _buildFooterHint('↵', 'to select'),
          const SizedBox(width: AppDesign.spaceM),
          _buildFooterHint('esc', 'to close'),
        ],
      ),
    );
  }

  Widget _buildFooterHint(String key, String action) {
    return Row(
      children: [
        Text(
          key,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          action,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}
