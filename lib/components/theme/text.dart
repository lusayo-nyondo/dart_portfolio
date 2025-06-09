import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/text.dart';

/// Defines a set of standard text styles for various typography scales.
/// Mimics Flutter's TextTheme for consistent text styling.
class TextTheme {
  final TextStyle headlineLarge; // New in M3, maps to headline1 sometimes
  final TextStyle headlineMedium; // New in M3, maps to headline2 sometimes
  final TextStyle headlineSmall; // New in M3, maps to headline3 sometimes
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle labelLarge; // Button text
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const TextTheme({
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  // Factory constructor for a default light TextTheme (simplified for web)
  factory TextTheme.light({
    String? fontFamily,
    Color? displayColor,
    Color? bodyColor,
  }) {
    const defaultFontFamily = 'sans-serif';
    const defaultDisplayColor = Color('#FF333333'); // Dark gray for text
    const defaultBodyColor = Color('#FF444444');

    return TextTheme(
      // Display styles (large, prominent text)
      displayLarge: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 57.0.px,
          fontWeight: FontWeight.normal,
          color: displayColor ?? defaultDisplayColor),
      displayMedium: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 45.0.px,
          fontWeight: FontWeight.normal,
          color: displayColor ?? defaultDisplayColor),
      displaySmall: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 36.0.px,
          fontWeight: FontWeight.normal,
          color: displayColor ?? defaultDisplayColor),

      // Headline styles (titles, headings)
      headlineLarge: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 32.0.px,
          fontWeight: FontWeight.bold, // Adjusted for typical web use
          color: displayColor ?? defaultDisplayColor),
      headlineMedium: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 28.0.px,
          fontWeight: FontWeight.bold,
          color: displayColor ?? defaultDisplayColor),
      headlineSmall: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 24.0.px,
          fontWeight: FontWeight.bold,
          color: displayColor ?? defaultDisplayColor),

      // Title styles (smaller headings, subtitles)
      titleLarge: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 22.0.px,
          fontWeight: FontWeight.bold,
          color: displayColor ?? defaultDisplayColor),
      titleMedium: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 16.0.px,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.15.px,
          color: displayColor ?? defaultDisplayColor),
      titleSmall: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 14.0.px,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.1.px,
          color: displayColor ?? defaultDisplayColor),

      // Body styles (main text content)
      bodyLarge: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 16.0.px,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5.px,
          color: bodyColor ?? defaultBodyColor),
      bodyMedium: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 14.0.px,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25.px,
          color: bodyColor ?? defaultBodyColor),
      bodySmall: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 12.0.px,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4.px,
          color: bodyColor ?? defaultBodyColor),

      // Label styles (button text, captions, etc.)
      labelLarge: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 14.0.px,
          fontWeight: FontWeight.bold, // M3 default for labels
          letterSpacing: 1.25.px),
      labelMedium: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 12.0.px,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5.px),
      labelSmall: TextStyle(
          fontFamily: fontFamily ?? defaultFontFamily,
          fontSize: 11.0.px,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5.px),
    );
  }

  // A basic copyWith method for TextTheme (can be extended)
  TextTheme copyWith({
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return TextTheme(
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }
}
