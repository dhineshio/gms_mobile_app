import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/theme_provider.dart';

/// Shared light/dark switcher: shows a sun in dark mode and a moon in light
/// mode. Drop it in any app bar or header row.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return IconButton(
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: themeProvider.toggleTheme,
      icon: Icon(
        isDark ? LucideIcons.sun : LucideIcons.moon,
        size: 19.sp,
      ),
    );
  }
}
