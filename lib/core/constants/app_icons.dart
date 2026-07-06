import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Semantic icon set for GMS, backed by [Lucide](https://lucide.dev) icons.
/// Reference icons through this class (e.g. `AppIcons.home`) rather than
/// `LucideIcons.*` directly so the underlying icon can be swapped in one place.
///
/// Usage: `Icon(AppIcons.home)`
class AppIcons {
  AppIcons._();

  static const IconData chat = LucideIcons.messageCircle;
  static const IconData home = LucideIcons.house;
  static const IconData status = LucideIcons.circleDashed;
  static const IconData groups = LucideIcons.users;
  static const IconData profile = LucideIcons.circleUser;
}
