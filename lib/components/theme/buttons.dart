import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/text.dart';

/// Defines the visual properties for standard buttons within the theme.
class ButtonThemeData {
  final Color? backgroundColor;
  final Color? foregroundColor; // Color of text/icons on the button
  final TextStyle? textStyle;
  final Spacing? padding;
  final double? borderRadius; // Corner radius in pixels
  final double? elevation; // For shadow

  const ButtonThemeData({
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.elevation,
  });
}
