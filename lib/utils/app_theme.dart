import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_manager/utils/config.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color surfaceMuted;
  final Color buttonSurface;
  final Color buttonSurfaceVariant;
  final Color foreground;
  final Color foregroundMuted;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceMuted,
    required this.buttonSurface,
    required this.buttonSurfaceVariant,
    required this.foreground,
    required this.foregroundMuted,
  });

  static const AppColors dark = AppColors(
    background: Color(0xFF212121),
    surface: Color(0xFF303030),
    surfaceVariant: Color(0xFF424242),
    surfaceMuted: Color(0xFF616161),
    buttonSurface: Color(0xFF263238),
    buttonSurfaceVariant: Color(0xFF37474F),
    foreground: Color(0xFFFFFFFF),
    foregroundMuted: Color(0xB3FFFFFF),
  );

  static const AppColors light = AppColors(
    background: Color(0xFFF5F5F5),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFE0E0E0),
    surfaceMuted: Color(0xFFBDBDBD),
    buttonSurface: Color(0xFFECEFF1),
    buttonSurfaceVariant: Color(0xFFCFD8DC),
    foreground: Color(0xFF212121),
    foregroundMuted: Color(0x8A000000),
  );

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>() ?? dark;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? surfaceMuted,
    Color? buttonSurface,
    Color? buttonSurfaceVariant,
    Color? foreground,
    Color? foregroundMuted,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      buttonSurface: buttonSurface ?? this.buttonSurface,
      buttonSurfaceVariant: buttonSurfaceVariant ?? this.buttonSurfaceVariant,
      foreground: foreground ?? this.foreground,
      foregroundMuted: foregroundMuted ?? this.foregroundMuted,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      buttonSurface: Color.lerp(buttonSurface, other.buttonSurface, t)!,
      buttonSurfaceVariant:
          Color.lerp(buttonSurfaceVariant, other.buttonSurfaceVariant, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      foregroundMuted: Color.lerp(foregroundMuted, other.foregroundMuted, t)!,
    );
  }
}

class AppTheme {
  static ThemeData _build(Brightness brightness, AppColors colors) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark()
        : ThemeData.light();
    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[colors],
      primaryColor: Colors.blueAccent,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      cardColor: colors.surface,
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: colors.foreground,
        displayColor: colors.foreground,
      ),
      iconTheme: IconThemeData(color: colors.foregroundMuted, size: 20),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colors.surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      colorScheme: (brightness == Brightness.dark
              ? const ColorScheme.dark()
              : const ColorScheme.light())
          .copyWith(
        primary: Colors.blueAccent,
        surface: colors.surface,
        onSurface: colors.foreground,
      ),
    );
  }

  static ThemeData get dark => _build(Brightness.dark, AppColors.dark);
  static ThemeData get light => _build(Brightness.light, AppColors.light);
}

class ThemeController {
  static final ValueNotifier<ThemeMode> notifier =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  static void init() {
    notifier.value = _fromString(ConfigUtils.themeMode);
  }

  static Future<void> set(ThemeMode mode) async {
    if (notifier.value == mode) return;
    notifier.value = mode;
    ConfigUtils.themeMode = _toString(mode);
    await ConfigUtils.save();
  }

  static ThemeMode _fromString(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static String _toString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
