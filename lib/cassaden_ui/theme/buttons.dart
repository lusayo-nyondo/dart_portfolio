import 'package:jaspr/jaspr.dart';

import 'package:json_annotation/json_annotation.dart';

import 'text.dart';

import '../components/extensions/extensions.dart';

part 'buttons.g.dart';

/// Defines the visual properties for standard buttons within the theme.
@JsonSerializable(converters: [
  ColorConverter(),
  SpacingConverter(),
])
class ButtonTheme {
  final Color? backgroundColor;
  final Color? foregroundColor; // Color of text/icons on the button
  final TextStyle? textStyle;
  final Spacing? padding;
  final double? borderRadius; // Corner radius in pixels
  final double? elevation; // For shadow

  const ButtonTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.elevation,
  });

  factory ButtonTheme.fromJson(Map<String, dynamic> json) =>
      _$ButtonThemeFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonThemeToJson(this);
}
