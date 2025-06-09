import 'package:jaspr/jaspr.dart';

import 'app_bar.dart';
import 'buttons.dart';
import 'colors.dart';
import 'text.dart';

enum Brightness { light, dark }

/// The core class that defines the visual theme for a Jaspr application.
/// Mimics Flutter's ThemeData, combining colors, typography, and component themes.
class ThemeData {
  final Brightness brightness;
  final ColorTheme colorScheme;
  final TextTheme textTheme;
  final AppBarTheme appBarTheme;
  final ButtonThemeData buttonTheme;

  // Global defaults
  final String? fontFamily;
  final Color? scaffoldBackgroundColor;
  final double? defaultBorderRadius; // Default for many rounded elements

  const ThemeData({
    required this.colorScheme,
    required this.textTheme,
    this.brightness = Brightness.dark,
    this.appBarTheme = const AppBarTheme(),
    this.buttonTheme = const ButtonThemeData(),
    this.fontFamily,
    this.scaffoldBackgroundColor,
    this.defaultBorderRadius = 4.0, // Default Material-like border radius
  });

  // Factory constructor for a default light theme
  factory ThemeData.light({
    ColorTheme? colorScheme,
    TextTheme? textTheme,
    AppBarTheme? appBarTheme,
    ButtonThemeData? buttonTheme,
    String? fontFamily,
    Color? scaffoldBackgroundColor,
    double? defaultBorderRadius,
  }) {
    final defaultColorTheme = ColorTheme.light();
    final defaultTextTheme = TextTheme.light(
      displayColor: defaultColorTheme.onBackground,
      bodyColor: defaultColorTheme.onBackground,
    );

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme ?? defaultColorTheme,
      textTheme: textTheme ?? defaultTextTheme,
      appBarTheme: appBarTheme ??
          AppBarTheme(
            backgroundColor: defaultColorTheme.primary,
            foregroundColor: defaultColorTheme.onPrimary,
            titleTextStyle: defaultTextTheme.titleLarge
                .copyWith(color: defaultColorTheme.onPrimary),
            elevation: 4.0, // Default app bar shadow
          ),
      buttonTheme: buttonTheme ??
          ButtonThemeData(
            backgroundColor: defaultColorTheme.primary,
            foregroundColor: defaultColorTheme.onPrimary,
            textStyle: defaultTextTheme.labelLarge
                .copyWith(color: defaultColorTheme.onPrimary),
            padding: Spacing.symmetric(horizontal: 16.px, vertical: 8.px),
            borderRadius: defaultBorderRadius ?? 4.0,
            elevation: 2.0, // Default button shadow
          ),
      fontFamily: fontFamily ?? 'sans-serif',
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? defaultColorTheme.background,
      defaultBorderRadius: defaultBorderRadius ?? 4.0,
    );
  }

  // Factory constructor for a default dark theme
  factory ThemeData.dark({
    ColorTheme? colorScheme,
    TextTheme? textTheme,
    AppBarTheme? appBarTheme,
    ButtonThemeData? buttonTheme,
    String? fontFamily,
    Color? scaffoldBackgroundColor,
    double? defaultBorderRadius,
  }) {
    final defaultColorTheme = ColorTheme.dark();
    final defaultTextTheme = TextTheme.light(
      // Start with light, then adjust colors
      displayColor: defaultColorTheme.onBackground,
      bodyColor: defaultColorTheme.onBackground,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: colorScheme ?? defaultColorTheme,
      textTheme: textTheme ?? defaultTextTheme,
      appBarTheme: appBarTheme ??
          AppBarTheme(
            backgroundColor: defaultColorTheme
                .surface, // Dark theme AppBars often match surface
            foregroundColor: defaultColorTheme.onSurface,
            titleTextStyle: defaultTextTheme.titleLarge
                .copyWith(color: defaultColorTheme.onSurface),
            elevation: 4.0,
          ),
      buttonTheme: buttonTheme ??
          ButtonThemeData(
            backgroundColor: defaultColorTheme.primary,
            foregroundColor: defaultColorTheme.onPrimary,
            textStyle: defaultTextTheme.labelLarge
                .copyWith(color: defaultColorTheme.onPrimary),
            padding: Spacing.symmetric(horizontal: 16.px, vertical: 8.px),
            borderRadius: defaultBorderRadius ?? 4.0,
            elevation: 2.0,
          ),
      fontFamily: fontFamily ?? 'sans-serif',
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? defaultColorTheme.background,
      defaultBorderRadius: defaultBorderRadius ?? 4.0,
    );
  }

  // Static method to retrieve the current ThemeData from the BuildContext.
  // This is how child widgets access the theme.
  static ThemeData of(BuildContext context) {
    final ThemeProvider? inheritedTheme =
        context.dependOnInheritedComponentOfExactType<ThemeProvider>();
    assert(inheritedTheme != null,
        'No ThemeData found in context. Wrap your app in a JasprApp to provide a theme.');
    return inheritedTheme!.themeData;
  }
}

class ThemeProvider extends InheritedComponent {
  const ThemeProvider({
    required this.themeData,
    required super.child,
    super.key,
  });

  final ThemeData themeData;

  @override
  bool updateShouldNotify(covariant ThemeProvider oldComponent) {
    return themeData != oldComponent.themeData;
  }
}

// lib/theme/theme_mode.dart
enum ThemeMode {
  system, // Respects user's system preferences (prefers-color-scheme)
  light, // Always light mode
  dark, // Always dark mode
}
