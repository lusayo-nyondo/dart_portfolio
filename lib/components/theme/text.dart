import 'package:jaspr/jaspr.dart';

import 'package:json_annotation/json_annotation.dart';

/// An enum for specifying text direction.
enum TextDirection {
  ltr,
  rtl,
}

/// An immutable style describing how to format text.
///
/// Mimics Flutter's [TextStyle] class.
class TextStyle {
  final Unit? fontSize;
  final FontWeight? fontWeight; // Jaspr's FontWeight enum
  final Color? color;
  final String? fontFamily;
  final TextDecoration? decoration; // Jaspr's TextDecoration enum
  final Color? decorationColor;
  final TextDecorationStyle?
      decorationStyle; // Jaspr's TextDecorationStyle enum
  final Unit? letterSpacing; // Jaspr's Unit for letter spacing
  final Unit? wordSpacing; // Jaspr's Unit for word spacing
  final Unit? lineHeight; // Jaspr's Unit for line-height (e.g., 1.2.em, 24.px)
  final FontStyle? fontStyle; // Jaspr's FontStyle enum

  const TextStyle({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.lineHeight,
    this.fontStyle,
  });

  // Updated: Method to convert TextStyle properties into a raw Map for Styles(raw: ...)
  Map<String, String> toCssMap() {
    final Map<String, String> map = {};

    if (fontSize != null) {
      map['font-size'] =
          fontSize!.value; // Convert Unit to CSS string (e.g., "16px")
    }
    if (fontWeight != null) {
      map['font-weight'] = fontWeight!
          .value; // Convert enum to CSS string (e.g., "bold" or "700")
    }
    if (color != null) {
      map['color'] =
          color!.value; // Convert Color to CSS string (e.g., "#RRGGBB")
    }
    if (fontFamily != null) {
      map['font-family'] = fontFamily!; // fontFamily will be just the string
    }
    if (decoration != null) {
      map['text-decoration'] = decoration!.value; // Convert enum to CSS string
    }
    if (decorationColor != null) {
      map['text-decoration-color'] =
          decorationColor!.value; // Convert Color to CSS string
    }
    if (decorationStyle != null) {
      map['text-decoration-style'] =
          decorationStyle!.value; // Convert enum to CSS string
    }
    if (letterSpacing != null) map['letter-spacing'] = letterSpacing!.value;
    if (wordSpacing != null) map['word-spacing'] = wordSpacing!.value;
    if (lineHeight != null) map['line-height'] = lineHeight!.value;
    if (fontStyle != null) map['font-style'] = fontStyle!.value;

    return map;
  }

  TextStyle copyWith({
    Unit? fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    Unit? letterSpacing,
    Unit? wordSpacing,
    Unit? lineHeight,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
      fontFamily: fontFamily ?? this.fontFamily,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      lineHeight: lineHeight ?? this.lineHeight,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }
}

/// Defines a set of standard text styles for various typography scales.
/// Mimics Flutter's TextTheme for consistent text styling.
///
@JsonSerializable()
class TextTheme {
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
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
