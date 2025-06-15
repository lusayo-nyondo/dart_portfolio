import 'package:jaspr/jaspr.dart';

import 'package:json_annotation/json_annotation.dart';

import 'text.dart';

import '../components/core/extensions/extensions.dart';

part 'app_bar.g.dart';

/// Defines the visual properties for AppBars within the theme.
@JsonSerializable(converters: [
  ColorConverter(),
])
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

  factory AppBarTheme.fromJson(Map<String, dynamic> json) =>
      _$AppBarThemeFromJson(json);

  Map<String, dynamic> toJson() => _$AppBarThemeToJson(this);
}
