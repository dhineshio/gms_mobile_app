import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper over [SharedPreferences] for persisting the auth token and
/// other simple key/value app state. Call [init] once during app start-up.
class LocalStorageService {
  LocalStorageService._();

  static late final SharedPreferences _prefs;

  static const String _gmsAccessToken = 'gms_access_token';
  static const String _gmsThemeMode = 'gms_theme_mode';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ===== Auth token =====
  static String? get accessToken => _prefs.getString(_gmsAccessToken);

  static Future<void> setToken(String token) =>
      _prefs.setString(_gmsAccessToken, token);

  static Future<void> clearToken() => _prefs.remove(_gmsAccessToken);

  // ===== Theme =====
  // Stored as 'dark' | 'light'. Returns null if never saved.
  static String? get savedThemeMode => _prefs.getString(_gmsThemeMode);

  static Future<void> saveThemeMode(String mode) =>
      _prefs.setString(_gmsThemeMode, mode);

  // ===== Generic helpers =====
  static Future<void> clearAll() => _prefs.clear();
}
