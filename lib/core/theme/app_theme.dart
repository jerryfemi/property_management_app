import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    const colorScheme = ColorScheme.light(
      primary: AppColorsLight.primary,
      secondary: AppColorsLight.accent,
      surface: AppColorsLight.surface,
      error: AppColorsLight.danger,
      onPrimary: AppColorsLight.surface,
      onSecondary: AppColorsLight.surface,
      onSurface: AppColorsLight.dark,
      onError: AppColorsLight.surface,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: colorScheme,
      extensions: const <ThemeExtension<dynamic>>[AppExtraColors.light],
      scaffoldBackgroundColor: AppColorsLight.background,
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: AppColorsLight.dark,
        displayColor: AppColorsLight.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorsLight.surface,
        foregroundColor: AppColorsLight.dark,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppColorsLight.surface,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColorsLight.primaryLight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? AppColorsLight.primary
                : AppColorsLight.muted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColorsLight.primary
                : AppColorsLight.muted,
          );
        }),
      ),
      dividerColor: AppColorsLight.border,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.muted.withValues(alpha: 0.05),
        hintStyle: const TextStyle(color: AppColorsLight.muted),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsLight.border),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsLight.border),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsLight.primary),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // dark theme
  static ThemeData dark() {
    const colorScheme = ColorScheme.dark(
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.accent,
      surface: AppColorsDark.surface,
      error: AppColorsDark.danger,
      onPrimary: AppColorsDark.surface,
      onSecondary: AppColorsDark.surface,
      onSurface: Colors.white,
      onError: AppColorsDark.surface,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: colorScheme,
      extensions: const <ThemeExtension<dynamic>>[AppExtraColors.dark],
      scaffoldBackgroundColor: AppColorsDark.background,
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: AppColorsDark.dark,
        displayColor: AppColorsDark.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorsDark.surface,
        foregroundColor: AppColorsDark.dark,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColorsDark.surface,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColorsDark.primaryLight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? AppColorsDark.primary
                : AppColorsDark.muted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColorsDark.primary
                : AppColorsDark.muted,
          );
        }),
      ),
      dividerColor: AppColorsDark.border,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.muted.withValues(alpha: 0.08),
        hintStyle: const TextStyle(color: AppColorsDark.muted),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsDark.border),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsDark.border),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsDark.primary),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class AppExtraColors extends ThemeExtension<AppExtraColors> {
  const AppExtraColors({
    required this.primaryLight,
    required this.accentLight,
    required this.dangerLight,
    required this.warning,
    required this.warningLight,
    required this.muted,
    required this.border,
    required this.background,
    required this.surface,
  });

  final Color primaryLight;
  final Color accentLight;
  final Color dangerLight;
  final Color warning;
  final Color warningLight;
  final Color muted;
  final Color border;
  final Color background;
  final Color surface;

  static const light = AppExtraColors(
    primaryLight: AppColorsLight.primaryLight,
    accentLight: AppColorsLight.accentLight,
    dangerLight: AppColorsLight.dangerLight,
    warning: AppColorsLight.warning,
    warningLight: AppColorsLight.warningLight,
    muted: AppColorsLight.muted,
    border: AppColorsLight.border,
    background: AppColorsLight.background,
    surface: AppColorsLight.surface,
  );

  static const dark = AppExtraColors(
    primaryLight: AppColorsDark.primaryLight,
    accentLight: AppColorsDark.accentLight,
    dangerLight: AppColorsDark.dangerLight,
    warning: AppColorsDark.warning,
    warningLight: AppColorsDark.warningLight,
    muted: AppColorsDark.muted,
    border: AppColorsDark.border,
    background: AppColorsDark.background,
    surface: AppColorsDark.surface,
  );

  @override
  AppExtraColors copyWith({
    Color? primaryLight,
    Color? accentLight,
    Color? dangerLight,
    Color? warning,
    Color? warningLight,
    Color? muted,
    Color? border,
    Color? background,
    Color? surface,
  }) {
    return AppExtraColors(
      primaryLight: primaryLight ?? this.primaryLight,
      accentLight: accentLight ?? this.accentLight,
      dangerLight: dangerLight ?? this.dangerLight,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      muted: muted ?? this.muted,
      border: border ?? this.border,
      background: background ?? this.background,
      surface: surface ?? this.surface,
    );
  }

  @override
  AppExtraColors lerp(ThemeExtension<AppExtraColors>? other, double t) {
    if (other is! AppExtraColors) {
      return this;
    }
    return AppExtraColors(
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      dangerLight: Color.lerp(dangerLight, other.dangerLight, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      border: Color.lerp(border, other.border, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
    );
  }
}

extension AppThemeColors on BuildContext {
  AppExtraColors get appColors {
    return Theme.of(this).extension<AppExtraColors>()!;
  }
}
