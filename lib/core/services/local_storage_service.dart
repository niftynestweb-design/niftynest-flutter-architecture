import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Theme Persistence
  static const String _themeKey = 'theme_mode';
  
  static Future<void> setThemeMode(String mode) async {
    await _prefs.setString(_themeKey, mode);
  }

  static String? getThemeMode() {
    return _prefs.getString(_themeKey);
  }

  // Sidebar Persistence
  static const String _sidebarKey = 'sidebar_collapsed';

  static bool getSidebarCollapsed() => _prefs.getBool(_sidebarKey) ?? false;
  static Future<void> setSidebarCollapsed(bool value) => _prefs.setBool(_sidebarKey, value);

  // Onboarding Persistence
  static const String _onboardingKey = 'onboarding_shown';
  static bool getOnboardingShown() => _prefs.getBool(_onboardingKey) ?? false;
  static Future<void> setOnboardingShown(bool value) => _prefs.setBool(_onboardingKey, value);
}
