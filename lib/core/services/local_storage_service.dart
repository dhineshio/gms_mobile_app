import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper over [SharedPreferences] for persisting the auth token and
/// other simple key/value app state. Call [init] once during app start-up.
class LocalStorageService {
  LocalStorageService._();

  // Not `final` so init() can be called again (e.g. between tests).
  static late SharedPreferences _prefs;

  static const String _gmsAccessToken = 'gms_access_token';
  static const String _gmsRefreshToken = 'gms_refresh_token';
  static const String _gmsUser = 'gms_user';
  static const String _gmsThemeMode = 'gms_theme_mode';
  static const String _gmsOnboardingDone = 'gms_onboarding_done';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ===== Auth token =====
  static String? get accessToken => _prefs.getString(_gmsAccessToken);

  static Future<void> setToken(String token) =>
      _prefs.setString(_gmsAccessToken, token);

  static Future<void> clearToken() => _prefs.remove(_gmsAccessToken);

  static String? get refreshToken => _prefs.getString(_gmsRefreshToken);

  static Future<void> setRefreshToken(String token) =>
      _prefs.setString(_gmsRefreshToken, token);

  // ===== Logged-in user (JSON string) =====
  static String? get savedUserJson => _prefs.getString(_gmsUser);

  static Future<void> saveUserJson(String json) =>
      _prefs.setString(_gmsUser, json);

  /// Clears everything tied to the logged-in session (tokens + user).
  static Future<void> clearSession() async {
    await _prefs.remove(_gmsAccessToken);
    await _prefs.remove(_gmsRefreshToken);
    await _prefs.remove(_gmsUser);
  }

  // ===== Theme =====
  // Stored as 'dark' | 'light'. Returns null if never saved.
  static String? get savedThemeMode => _prefs.getString(_gmsThemeMode);

  static Future<void> saveThemeMode(String mode) =>
      _prefs.setString(_gmsThemeMode, mode);

  // ===== Onboarding =====
  static bool get hasSeenOnboarding =>
      _prefs.getBool(_gmsOnboardingDone) ?? false;

  static Future<void> setOnboardingSeen() =>
      _prefs.setBool(_gmsOnboardingDone, true);

  // ===== Generic helpers =====
  static Future<void> clearAll() => _prefs.clear();
}
