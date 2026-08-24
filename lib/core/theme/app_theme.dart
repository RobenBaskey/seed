import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import 'app_text_styles.dart';

/// Builds the app's [ThemeData]. Consumed by `GetMaterialApp` in
/// main.dart. Every component theme here (buttons, inputs, cards, chips,
/// app bar, bottom nav) is the single source of truth for that
/// component's look — prefer tuning it here over overriding styles at
/// call sites.
class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => _buildTheme(brightness: Brightness.light);

  static ThemeData get darkTheme => _buildTheme(brightness: Brightness.dark);

  static ThemeData _buildTheme({required Brightness brightness}) {
    final isDark = brightness == Brightness.dark;

    final background = isDark ? AppColors.backgroundDark : AppColors.background;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surface;
    final surfaceAlt = isDark ? AppColors.surfaceAltDark : AppColors.surfaceAlt;
    final border = isDark ? AppColors.borderDark : AppColors.border;
    final textPrimary = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final primary = isDark ? AppColors.primary400 : AppColors.primary;

    final textTheme = TextTheme(
      displayMedium: AppTextStyles.displayMedium.copyWith(color: textPrimary),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: textPrimary),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: textPrimary),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: textPrimary),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: textPrimary),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: textPrimary),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: textPrimary),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: textSecondary),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textPrimary),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textPrimary),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: textSecondary),
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium.copyWith(color: textPrimary),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: textSecondary),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: AppColors.textOnPrimary,
        secondary: isDark ? AppColors.secondary400 : AppColors.secondary,
        onSecondary: AppColors.textOnPrimary,
        error: AppColors.error,
        onError: AppColors.textOnPrimary,
        surface: surface,
        onSurface: textPrimary,
        outline: border,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.black.withValues(alpha: 0.08),
        centerTitle: false,
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(color: textPrimary),
        iconTheme: IconThemeData(color: textPrimary, size: 24),
        toolbarHeight: 60,
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: border),
        ),
      ),

      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: isDark ? AppColors.neutral700 : AppColors.neutral200,
          disabledForegroundColor: isDark ? AppColors.neutral500 : AppColors.neutral400,
          minimumSize: const Size.fromHeight(AppSpacing.minTouchTarget),
          textStyle: AppTextStyles.labelLarge,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          disabledForegroundColor: isDark ? AppColors.neutral500 : AppColors.neutral400,
          minimumSize: const Size.fromHeight(AppSpacing.minTouchTarget),
          textStyle: AppTextStyles.labelLarge.copyWith(color: primary),
          side: BorderSide(color: primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          disabledForegroundColor: isDark ? AppColors.neutral500 : AppColors.neutral400,
          minimumSize: const Size(0, AppSpacing.minTouchTarget),
          textStyle: AppTextStyles.labelLarge.copyWith(color: primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(AppSpacing.minTouchTarget, AppSpacing.minTouchTarget),
          foregroundColor: textPrimary,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
        floatingLabelStyle: AppTextStyles.bodyMedium.copyWith(color: primary),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: isDark ? AppColors.neutral500 : AppColors.neutral400),
        helperStyle: AppTextStyles.bodySmall.copyWith(color: textSecondary),
        errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: border.withValues(alpha: 0.5)),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceAlt,
        disabledColor: surfaceAlt,
        selectedColor: primary,
        labelStyle: AppTextStyles.labelMedium.copyWith(color: textPrimary),
        secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.textOnPrimary),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
          side: BorderSide(color: border),
        ),
        side: BorderSide(color: border),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        selectedLabelStyle: AppTextStyles.labelMedium,
        unselectedLabelStyle: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w500),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: (isDark ? AppColors.primary400 : AppColors.primary).withValues(alpha: 0.14),
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return AppTextStyles.labelMedium.copyWith(
            color: selected ? primary : textSecondary,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(color: selected ? primary : textSecondary);
        }),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: AppColors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.dialog)),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(color: textPrimary),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.neutral800 : AppColors.neutral900,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textOnDark),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),

      dividerColor: border,
    );
  }
}
