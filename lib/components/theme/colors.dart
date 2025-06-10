import 'package:jaspr/jaspr.dart';

import 'package:json_annotation/json_annotation.dart';

/// A [JsonConverter] that converts [Color] objects to and from their integer [value].
class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) {
    return Color(json);
  }

  @override
  String toJson(Color object) {
    return object.value;
  }
}

/// Defines a set of semantic colors for a Material Design-like theme.
/// Mimics Flutter's ColorScheme for consistent color usage.
@JsonSerializable(converters: [ColorConverter()])
class ColorTheme {
  final Color primary; // Primary brand color
  final Color primaryVariant; // Darker primary color
  final Color secondary; // Accent color
  final Color secondaryVariant; // Darker accent color
  final Color surface; // Color for cards, sheets, dialogs
  final Color background; // Scaffold background color
  final Color error; // Color for error states

  final Color onPrimary; // Color of text/icons on primary color
  final Color onSecondary; // Color of text/icons on secondary color
  final Color onSurface; // Color of text/icons on surface color
  final Color onBackground; // Color of text/icons on background color
  final Color onError; // Color of text/icons on error color

  const ColorTheme({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.surface,
    required this.background,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onSurface,
    required this.onBackground,
    required this.onError,
  });

  // Factory constructor for a default light theme ColorScheme
  factory ColorTheme.light({
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? surface,
    Color? background,
    Color? error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onSurface,
    Color? onBackground,
    Color? onError,
  }) {
    return ColorTheme(
      primary: primary ?? const Color('#FF6200EE'), // Deep purple
      primaryVariant: primaryVariant ?? const Color('#FF3700B3'),
      secondary: secondary ?? const Color('#FF03DAC6'), // Teal accent
      secondaryVariant: secondaryVariant ?? const Color('#FF018786'),
      surface: surface ?? Colors.white,
      background:
          background ?? const Color('#FFF0F0F0'), // Light gray background
      error: error ?? const Color('#FFB00020'),

      onPrimary: onPrimary ?? Colors.white,
      onSecondary: onSecondary ?? Colors.black,
      onSurface: onSurface ?? Colors.black,
      onBackground: onBackground ?? Colors.black,
      onError: onError ?? Colors.white,
    );
  }

  // Factory constructor for a default dark theme ColorScheme
  factory ColorTheme.dark({
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? surface,
    Color? background,
    Color? error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onSurface,
    Color? onBackground,
    Color? onError,
  }) {
    return ColorTheme(
      primary: primary ??
          const Color('#FFBB86FC'), // Lighter purple for dark theme primary
      primaryVariant: primaryVariant ?? const Color('#FF3700B3'),
      secondary: secondary ?? const Color('#FF03DAC6'),
      secondaryVariant: secondaryVariant ?? const Color('#FF03DAC6'),
      surface: surface ?? const Color('#FF121212'), // Dark surface
      background: background ?? const Color('#FF1A1A1A'), // Dark background
      error: error ?? const Color('#FFCF6679'),

      onPrimary: onPrimary ?? Colors.black,
      onSecondary: onSecondary ?? Colors.black,
      onSurface: onSurface ?? Colors.white,
      onBackground: onBackground ?? Colors.white,
      onError: onError ?? Colors.black,
    );
  }

  ColorTheme.fromJson(Map<String, dynamic> json) => _$ColorThemeFromJson(json);

  Map<String, dynamic> toJson() => _$ColorThemeToJson(this);
}
