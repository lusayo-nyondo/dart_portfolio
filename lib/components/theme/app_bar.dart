import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/text.dart';

/// Defines the visual properties for AppBars within the theme.
class AppBarTheme {
  final Color? backgroundColor;
  final Color? foregroundColor; // Color for icons and text in the app bar
  final TextStyle? titleTextStyle;
  final double? elevation; // For shadow (e.g., 2.0, 4.0)

  const AppBarTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.titleTextStyle,
    this.elevation,
  });
}
