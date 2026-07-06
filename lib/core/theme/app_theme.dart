import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(TextTheme base) =>
      GoogleFonts.outfitTextTheme(base);

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color background,
    required Color foreground,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        minimumSize: Size.fromHeight(6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.sp),
        ),
      ),
    );
  }

  /// Filled, rounded inputs with a subtle border that turns brand green on
  /// focus. Used by all text fields and dropdowns.
  static InputDecorationTheme _inputDecorationTheme({
    required Color fill,
    required Color border,
    required Color hint,
  }) {
    OutlineInputBorder side(Color color, [double width = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.sp),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.7.h),
      hintStyle: TextStyle(color: hint),
      border: side(border),
      enabledBorder: side(border),
      focusedBorder: side(AppColors.primary, 1.5),
      errorBorder: side(AppColors.error),
      focusedErrorBorder: side(AppColors.error, 1.5),
    );
  }

  /// WhatsApp-style app bar: flat, blends with the page, left-aligned bold
  /// title.
  static AppBarTheme _appBarTheme({
    required Color background,
    required Color foreground,
  }) {
    return AppBarTheme(
      backgroundColor: background,
      foregroundColor: foreground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: foreground,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  /// WhatsApp-style bottom navigation: flat bar with a soft green pill behind
  /// the selected icon, labels always visible and bold when selected.
  static NavigationBarThemeData _navigationBarTheme({
    required Color background,
    required Color selected,
    required Color unselected,
  }) {
    return NavigationBarThemeData(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.primary.withValues(alpha: 0.22),
      indicatorShape: const StadiumBorder(),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      elevation: 0,
      height: 9.h,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          size: 18.sp,
          color: states.contains(WidgetState.selected) ? selected : unselected,
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 9.sp,
          letterSpacing: 0.2,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w400,
          color: states.contains(WidgetState.selected) ? selected : unselected,
        ),
      ),
    );
  }

  /// WhatsApp-style FAB: rounded square in brand green.
  static FloatingActionButtonThemeData _fabTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
    );
  }

  // ===== Dark (default) =====
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onTertiary: AppColors.onTertiary,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: _appBarTheme(
      background: AppColors.background,
      foreground: AppColors.textPrimary,
    ),
    elevatedButtonTheme: _elevatedButtonTheme(
      background: AppColors.primary,
      foreground: AppColors.onPrimary,
    ),
    navigationBarTheme: _navigationBarTheme(
      background: AppColors.background,
      selected: AppColors.textPrimary,
      unselected: AppColors.textSecondary,
    ),
    floatingActionButtonTheme: _fabTheme(),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.textSecondary,
      textColor: AppColors.textPrimary,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.white.withValues(alpha: 0.08),
      thickness: 0.5,
      space: 0.5,
    ),
    inputDecorationTheme: _inputDecorationTheme(
      fill: AppColors.surface,
      border: AppColors.white.withValues(alpha: 0.10),
      hint: AppColors.textSecondary.withValues(alpha: 0.7),
    ),
    textTheme: _textTheme(ThemeData.dark().textTheme),
  );

  // ===== Light =====
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onTertiary: AppColors.onTertiary,
      onSurface: AppColors.textOnLight,
    ),
    appBarTheme: _appBarTheme(
      background: AppColors.lightBackground,
      foreground: AppColors.textOnLight,
    ),
    elevatedButtonTheme: _elevatedButtonTheme(
      background: AppColors.primary,
      foreground: AppColors.onPrimary,
    ),
    navigationBarTheme: _navigationBarTheme(
      background: AppColors.lightBackground,
      selected: AppColors.textOnLight,
      unselected: AppColors.textSecondary,
    ),
    floatingActionButtonTheme: _fabTheme(),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.textSecondary,
      textColor: AppColors.textOnLight,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.neutral.withValues(alpha: 0.08),
      thickness: 0.5,
      space: 0.5,
    ),
    inputDecorationTheme: _inputDecorationTheme(
      fill: AppColors.lightSurface,
      border: AppColors.neutral.withValues(alpha: 0.12),
      hint: AppColors.textOnLight.withValues(alpha: 0.4),
    ),
    textTheme: _textTheme(ThemeData.light().textTheme),
  );
}
