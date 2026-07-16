import 'package:flutter/material.dart';

/// GMS brand palette and semantic colors.
class AppColors {
  AppColors._();

  // Brand palette
  static const Color primary = Color(0xFF069C55); // GMS green (logo background)
  static const Color secondary = Color(0xFF0053DB); // blue
  static const Color tertiary = Color(0xFFD5C4AD); // tan
  static const Color neutral = Color(0xFF131313); // near-black

  // Surfaces / background (dark-first to match the design mock)
  static const Color background = neutral; // #131313
  static const Color surface = Color(0xFF1E1E1E); // slightly lifted card

  // Light-theme surfaces
  static const Color lightBackground = Color(0xFFF2F2F4); // light grey page
  static const Color lightSurface = Color(0xFFFFFFFF); // white cards stand out

  // Text
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textOnLight = Color(0xFF212121);

  // On-color (text/icon color drawn on top of a brand color)
  static const Color onPrimary = white; // light text on green (matches logo)
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onTertiary = neutral;

  // Status
  static const Color error = Color(0xFFD32F2F);
  static const Color success = primary;
  static const Color white = Color(0xFFFFFFFF);
}
