import 'package:dart_portfolio/components/extensions/extensions.dart';
import 'package:jaspr/jaspr.dart';
import 'package:json_annotation/json_annotation.dart';

import 'app_bar.dart';
import 'buttons.dart';
import 'colors.dart';
import 'text.dart';

export 'app_bar.dart';
export 'buttons.dart';
export 'colors.dart';
export 'text.dart';

part 'theme.g.dart';

enum Brightness { light, dark }

/// The core class that defines the visual theme for a Jaspr application.
/// Mimics Flutter's ThemeData, combining colors, typography, and component themes.
@JsonSerializable(converters: [ColorConverter()])
class ThemeData {
  final Brightness brightness;
  final ColorTheme colorScheme;
  final TextTheme textTheme;
  final AppBarTheme appBarTheme;
  final ButtonTheme buttonTheme;

  // Global defaults
  final String? fontFamily;
  final Color? scaffoldBackgroundColor;
  final double? defaultBorderRadius; // Default for many rounded elements

  const ThemeData({
    required this.colorScheme,
    required this.textTheme,
    this.brightness = Brightness.dark,
    this.appBarTheme = const AppBarTheme(),
    this.buttonTheme = const ButtonTheme(),
    this.fontFamily,
    this.scaffoldBackgroundColor,
    this.defaultBorderRadius = 4.0, // Default Material-like border radius
  });

  // Factory constructor for a default light theme
  factory ThemeData.light({
    ColorTheme? colorScheme,
    TextTheme? textTheme,
    AppBarTheme? appBarTheme,
    ButtonTheme? buttonTheme,
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
          ButtonTheme(
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
    ButtonTheme? buttonTheme,
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
          ButtonTheme(
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

  @decoder
  factory ThemeData.fromJson(Map<String, dynamic> json) =>
      _$ThemeDataFromJson(json);

  @encoder
  Map<String, dynamic> toJson() => _$ThemeDataToJson(this);
}

class Theme extends InheritedComponent {
  const Theme({
    required this.themeData,
    required super.child,
    super.key,
  });

  final ThemeData themeData;

  @override
  bool updateShouldNotify(covariant Theme oldComponent) {
    return themeData != oldComponent.themeData;
  }

  static ThemeData of(BuildContext context) {
    final Theme? inheritedTheme =
        context.dependOnInheritedComponentOfExactType<Theme>();
    assert(inheritedTheme != null,
        'No ThemeData found in context. Wrap your app in a JasprApp to provide a theme.');
    return inheritedTheme!.themeData;
  }
}

// lib/theme/theme_mode.dart
@JsonEnum()
enum ThemeMode {
  system, // Respects user's system preferences (prefers-color-scheme)
  light, // Always light mode
  dark, // Always dark mode
}
