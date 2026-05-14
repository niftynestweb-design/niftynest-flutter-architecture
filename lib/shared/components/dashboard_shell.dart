import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_design_system.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/local_storage_service.dart';
import 'onboarding_overlay.dart';
import 'command_palette.dart';
import 'sidebar.dart';
import 'top_bar.dart';

class DashboardShell extends ConsumerStatefulWidget {
  final Widget child;

  const DashboardShell({super.key, required this.child});

  @override
  ConsumerState<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends ConsumerState<DashboardShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOnboarding();
    });
  }

  void _checkOnboarding() {
    if (!LocalStorageService.getOnboardingShown()) {
      OnboardingOverlay.show(context);
      LocalStorageService.setOnboardingShown(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          final isK = event.logicalKey == LogicalKeyboardKey.keyK;
          final isMeta = HardwareKeyboard.instance.isMetaPressed || HardwareKeyboard.instance.isControlPressed;
          
          if (isK && isMeta) {
            CommandPalette.show(context);
          }
        }
      },
      child: Scaffold(
        drawer: !Responsive.isDesktop(context)
            ? const Drawer(
                child: Sidebar(),
              )
            : null,
        body: Row(
          children: [
            if (Responsive.isDesktop(context)) const Sidebar(),
            Expanded(
              child: Column(
                children: [
                  const TopBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDesign.spaceXL),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
