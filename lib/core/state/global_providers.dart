import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';

class SidebarController extends Notifier<bool> {
  @override
  bool build() {
    return LocalStorageService.getSidebarCollapsed();
  }

  void toggle() {
    state = !state;
    LocalStorageService.setSidebarCollapsed(state);
  }

  void setCollapsed(bool value) {
    state = value;
    LocalStorageService.setSidebarCollapsed(value);
  }
}

final sidebarControllerProvider = NotifierProvider<SidebarController, bool>(() {
  return SidebarController();
});
