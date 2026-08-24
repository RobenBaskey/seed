import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Typography scale for the app. Widgets should prefer
/// `Theme.of(context).textTheme` (wired up in [AppTheme]) over these
/// directly, but they remain available for one-off usages.
///
/// Sizes and weights are tuned for readability at arm's length outdoors:
/// body text starts at 15sp (not the more common 14sp), line-heights are
/// generous, and emphasis leans on weight (600/700) rather than size
/// alone so hierarchy still reads in bright sunlight or on a low-quality
/// screen.
class AppTextStyles {
  const AppTextStyles._();

  static const String fontFamily = 'Roboto';

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    height: 40 / 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    height: 24 / 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
