/// Spacing scale used across the app for padding, margin and gaps.
/// Keeps layout rhythm consistent instead of hardcoding magic numbers.
/// Border radius lives in [AppRadius] instead — see core/constants/app_radius.dart.
class AppSpacing {
  const AppSpacing._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  /// Standard horizontal page padding.
  static const double pagePadding = md;

  /// Standard internal padding for cards and similar surfaces.
  static const double cardPadding = md;

  /// Vertical gap between distinct sections on a screen.
  static const double sectionGap = lg;

  /// Minimum recommended touch target size (accessibility + gloved/
  /// outdoor use), applied to buttons, list rows, and icon buttons.
  static const double minTouchTarget = 48;
}
