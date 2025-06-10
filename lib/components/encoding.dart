import 'package:jaspr/jaspr.dart';

import 'components.dart';

extension type ColorEncoding(Color color) implements Color {
  @decoder
  factory ColorEncoding.decode(String value) {
    return ColorEncoding(
      Color(value),
    );
  }

  @encoder
  String encode() {
    return value;
  }
}

extension ThemeDataExtractor on Map<String, dynamic> {
  ColorTheme toColorTheme() {
    return ColorTheme.light();
  }

  TextTheme toTextTheme() {
    return TextTheme.light();
  }

  AppBarTheme toAppBarTheme() {
    return AppBarTheme();
  }

  ButtonThemeData toButtonTheme() {
    return ButtonThemeData();
  }
}

extension type TextStyleEncoding(TextStyle textStyle) implements TextStyle {
  @decoder
  factory TextStyleEncoding.decode(Map<String, dynamic> data) {
    return TextStyleEncoding(
      TextStyle(),
    );
  }

  @encoder
  Map<String, dynamic> encode() {
    return {
      'fontFamily': fontFamily,
      'fontSize': fontSize?.value,
      'fontWeight': fontWeight.toString(),
      'fontStyle': fontStyle.toString(),
      'letterSpacing': letterSpacing,
      'wordSpacing': wordSpacing,
    };
  }
}

extension type TextThemeEncoding(TextTheme textTheme) implements TextTheme {
  @decoder
  factory TextThemeEncoding.decode(Map<String, dynamic> data) {
    return TextThemeEncoding(
      TextTheme.light(),
    );
  }

  @encoder
  Map<String, dynamic> encode() {
    return {
      'headlineLarge': TextStyleEncoding(headlineLarge).encode(),
      'headlineMedium': TextStyleEncoding(headlineLarge).encode(),
      'headlineSmall': TextStyleEncoding(headlineLarge).encode(),
      'displayLarge': TextStyleEncoding(headlineLarge).encode(),
      'displayMedium': TextStyleEncoding(headlineLarge).encode(),
      'displaySmall': TextStyleEncoding(headlineLarge).encode(),
      'bodyLarge': TextStyleEncoding(headlineLarge).encode(),
      'bodyMedium': TextStyleEncoding(headlineLarge).encode(),
      'bodySmall': TextStyleEncoding(headlineLarge).encode(),
      'titleLarge': TextStyleEncoding(headlineLarge).encode(),
      'titleMedium': TextStyleEncoding(headlineLarge).encode(),
      'titleSmall': TextStyleEncoding(headlineLarge).encode(),
      'labelLarge': TextStyleEncoding(headlineLarge).encode(),
      'labelMedium': TextStyleEncoding(headlineLarge).encode(),
      'labelSmall': TextStyleEncoding(headlineLarge).encode(),
    };
  }
}

extension type ColorThemeEncoding(ColorTheme colorTheme) implements ColorTheme {
  @decoder
  factory ColorThemeEncoding.decode(Map<String, dynamic> data) {
    return ColorThemeEncoding(
      ColorTheme.light(),
    );
  }

  @encoder
  Map<String, dynamic> encode() {
    return {
      'primary': primary.value,
      'onPrimary': onPrimary.value,
      'secondary': secondary.value,
      'onSecondary': onSecondary.value,
      'error': error.value,
      'onError': onError.value,
      'background': background.value,
      'onBackground': onBackground.value,
      'surface': surface.value,
      'onSurface': onSurface.value,
    };
  }
}

extension type AppBarThemeEncoding(AppBarTheme appBarTheme)
    implements AppBarTheme {
  @decoder
  factory AppBarThemeEncoding.decode(Map<String, dynamic> data) {
    return AppBarThemeEncoding(
      AppBarTheme(),
    );
  }

  @encoder
  Map<String, dynamic> encode() {
    return {};
  }
}

extension type ButtonThemeDataEncoding(ButtonThemeData buttonThemeData)
    implements ButtonThemeData {
  @decoder
  factory ButtonThemeDataEncoding.decode(Map<String, dynamic> data) {
    return ButtonThemeDataEncoding(
      ButtonThemeData(),
    );
  }

  @encoder
  Map<String, dynamic> encode() {
    return {};
  }
}

extension type ThemeDataEncoding(ThemeData themeData) implements ThemeData {
  @decoder
  factory ThemeDataEncoding.decode(Map<String, dynamic> data) {
    return ThemeDataEncoding(
      ThemeData(
        brightness: Brightness.dark,
        colorScheme: data.toColorTheme(),
        textTheme: data.toTextTheme(),
        appBarTheme: data.toAppBarTheme(),
        buttonTheme: data.toButtonTheme(),
        fontFamily: data['fontFamily'],
        scaffoldBackgroundColor: data['scaffoldBackgroundColor']
            ? Color(data['scaffoldBackgroundColor'])
            : null,
        defaultBorderRadius:
            data['defaultBorderRadius'], // Default for many rounded elements
      ),
    );
  }

  @encoder
  Map<String, dynamic> encode() {
    return {
      'brightness': brightness.toString(),
      'defaultBorderRadius': defaultBorderRadius,
      'fontFamily': fontFamily,
      'scaffoldBackgroundColor': scaffoldBackgroundColor?.value,
      'textTheme': TextThemeEncoding(textTheme).encode(),
      'colorScheme': ColorThemeEncoding(colorScheme).encode(),
      'appBarTheme': AppBarThemeEncoding(appBarTheme).encode(),
      'buttonTheme': ButtonThemeDataEncoding(buttonTheme).encode(),
    };
  }
}
