import 'package:flutter/material.dart';

/// Centralized color palette. Everything else (theme, widgets, screens)
/// should reference these tokens rather than hardcoding colors, so the
/// look of the app can be re-tuned from one place.
///
/// Built for a B2B agricultural app read outdoors: text tokens are kept
/// near-black/near-white for maximum contrast rather than mid-gray, and
/// the brand palette favors saturated, unambiguous hues (crop green,
/// harvest amber) over muted pastels.
class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------------
  // Primary — crop green. Brand color, primary actions, active states.
  // ---------------------------------------------------------------------
  static const Color primary50 = Color(0xFFEAF6EE);
  static const Color primary100 = Color(0xFFCDEAD6);
  static const Color primary200 = Color(0xFFA0D5AF);
  static const Color primary300 = Color(0xFF6FBB85);
  static const Color primary400 = Color(0xFF479F63);
  static const Color primary500 = Color(0xFF2E8049);
  static const Color primary600 = Color(0xFF226339);
  static const Color primary700 = Color(0xFF1A4C2C);
  static const Color primary800 = Color(0xFF143923);
  static const Color primary900 = Color(0xFF0E2A19);

  /// The brand color for solid fills (buttons, active nav, selection).
  static const Color primary = primary600;

  // ---------------------------------------------------------------------
  // Secondary — harvest amber. Accents, highlights, secondary emphasis.
  // ---------------------------------------------------------------------
  static const Color secondary50 = Color(0xFFFDF3E7);
  static const Color secondary100 = Color(0xFFFAE1BF);
  static const Color secondary200 = Color(0xFFF5C989);
  static const Color secondary300 = Color(0xFFEFAE54);
  static const Color secondary400 = Color(0xFFE6952F);
  static const Color secondary500 = Color(0xFFD67D1B);
  static const Color secondary600 = Color(0xFFB2650F);
  static const Color secondary700 = Color(0xFF8C4E0C);
  static const Color secondary800 = Color(0xFF663909);
  static const Color secondary900 = Color(0xFF402406);

  static const Color secondary = secondary500;

  // ---------------------------------------------------------------------
  // Neutrals — cool, slightly green-tinted grays for text/surfaces.
  // ---------------------------------------------------------------------
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF6F8F6);
  static const Color neutral100 = Color(0xFFEBEFEC);
  static const Color neutral200 = Color(0xFFD7DED8);
  static const Color neutral300 = Color(0xFFB7C2B9);
  static const Color neutral400 = Color(0xFF8D9A8F);
  static const Color neutral500 = Color(0xFF687568);
  static const Color neutral600 = Color(0xFF4F5B50);
  static const Color neutral700 = Color(0xFF3A443B);
  static const Color neutral800 = Color(0xFF262E27);
  static const Color neutral900 = Color(0xFF141A15);
  static const Color neutral950 = Color(0xFF0A0D0A);

  // ---------------------------------------------------------------------
  // Semantic — status colors, each with a soft background + readable text
  // tone for badges/chips/banners.
  // ---------------------------------------------------------------------
  static const Color success = primary500;
  static const Color successBg = primary50;
  static const Color successText = primary700;

  static const Color warning = Color(0xFFC77700);
  static const Color warningBg = Color(0xFFFCEFDC);
  static const Color warningText = Color(0xFF7A4900);

  static const Color error = Color(0xFFC0362B);
  static const Color errorBg = Color(0xFFFBE9E7);
  static const Color errorText = Color(0xFF8C1D16);

  static const Color info = Color(0xFF1D6FA5);
  static const Color infoBg = Color(0xFFE6F1FA);
  static const Color infoText = Color(0xFF123F5E);

  static const Color neutralStatus = neutral500;
  static const Color neutralStatusBg = neutral100;
  static const Color neutralStatusText = neutral700;

  // ---------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------
  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral600;
  static const Color textTertiary = neutral400;
  static const Color textOnPrimary = neutral0;
  static const Color textOnDark = neutral50;

  // ---------------------------------------------------------------------
  // Surface / background / border (light theme)
  // ---------------------------------------------------------------------
  static const Color background = neutral50;
  static const Color surface = neutral0;
  static const Color surfaceAlt = neutral100;
  static const Color border = neutral200;
  static const Color borderStrong = neutral300;
  static const Color divider = neutral100;

  // ---------------------------------------------------------------------
  // Surface / background / border (dark theme)
  // ---------------------------------------------------------------------
  static const Color backgroundDark = neutral950;
  static const Color surfaceDark = neutral900;
  static const Color surfaceAltDark = neutral800;
  static const Color borderDark = neutral800;
  static const Color borderStrongDark = neutral700;
  static const Color textPrimaryDark = neutral50;
  static const Color textSecondaryDark = neutral300;

  static const Color white = neutral0;
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
}
