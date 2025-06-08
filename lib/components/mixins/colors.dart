part of 'mixins.dart';

enum _CssColorProperty {
  color(
      cssName: 'color',
      tailwindPrefix: ''), // No prefix for text color in Tailwind
  backgroundColor(cssName: 'background-color', tailwindPrefix: 'bg-'),
  borderColor(cssName: 'border-color', tailwindPrefix: 'border-'),
  borderTopColor(cssName: 'border-top-color', tailwindPrefix: 'border-t-'),
  borderRightColor(cssName: 'border-right-color', tailwindPrefix: 'border-r-'),
  borderBottomColor(
      cssName: 'border-bottom-color', tailwindPrefix: 'border-b-'),
  borderLeftColor(cssName: 'border-left-color', tailwindPrefix: 'border-l-'),
  outlineColor(cssName: 'outline-color', tailwindPrefix: 'outline-'),
  caretColor(cssName: 'caret-color', tailwindPrefix: 'caret-'),
  textDecorationColor(
      cssName: 'text-decoration-color', tailwindPrefix: 'decoration-'),
  textEmphasisColor(
      cssName: 'text-emphasis-color',
      tailwindPrefix: 'text-emphasis-'), // Less common in Tailwind directly
  columnRuleColor(
      cssName: 'column-rule-color',
      tailwindPrefix: 'column-rule-'), // Less common in Tailwind directly
  accentColor(cssName: 'accent-color', tailwindPrefix: 'accent-'),
  scrollbarColor(cssName: 'scrollbar-color', tailwindPrefix: null),
  scrollbarTrackColor(cssName: 'scrollbar-track-color', tailwindPrefix: null);

  final String cssName;
  final String? tailwindPrefix;

  const _CssColorProperty(
      {required this.cssName, required this.tailwindPrefix});
}

String? _getTailwindClassName(Color color, _CssColorProperty propertyType) {
  if (propertyType.tailwindPrefix == null) {
    return null;
  }

  TailwindColor tailwindColor = TailwindColor.fromJasprColor(color);
  return '${propertyType.tailwindPrefix}${tailwindColor.className}';
}

String? _getColorCssValue(Color color, _CssColorProperty propertyType) {
  return "#${(color as TailwindColor).toJasprColor()?.value}";
}

// --- Base Mixin for all Color Properties ---
mixin BaseColorPropertyMixin {
  /// Internal helper to get the Tailwind class name for a given color property.
  /// Needs to be overridden by concrete mixins to provide the correct [Color] instance
  /// and [_CssColorProperty] type.
  String? _getTailwindClass(Color? color, _CssColorProperty propertyType) {
    if (color == null) return null;
    return _getTailwindClassName(color, propertyType);
  }

  /// Internal helper to get the CSS color value for a given color property.
  /// Needs to be overridden by concrete mixins to provide the correct [Color] instance
  /// and [_CssColorProperty] type.
  String? _getCssValue(Color? color, _CssColorProperty propertyType) {
    if (color == null) return null;
    return _getColorCssValue(color, propertyType);
  }
}

// --- Specific Color Mixins ---

mixin ColorMixin on BaseColorPropertyMixin {
  Color? get color;

  String getTailwindClassName() =>
      _getTailwindClass(color, _CssColorProperty.color) ?? '';
  String getColorCss() => _getCssValue(color, _CssColorProperty.color) ?? '';
}

mixin BackgroundColorMixin on BaseColorPropertyMixin {
  Color? backgroundColor;

  String getTailwindBackgroundColor() =>
      _getTailwindClass(backgroundColor, _CssColorProperty.backgroundColor) ??
      '';
  String getBackgroundColorCss() =>
      _getCssValue(backgroundColor, _CssColorProperty.backgroundColor) ?? '';
}

mixin BorderColorMixin on BaseColorPropertyMixin {
  Color? borderColor;

  String getTailwindBorderColor() =>
      _getTailwindClass(borderColor, _CssColorProperty.borderColor) ?? '';
  String getBorderColorCss() =>
      _getCssValue(borderColor, _CssColorProperty.borderColor) ?? '';
}

mixin BorderTopColorMixin on BaseColorPropertyMixin {
  Color? borderTopColor;

  String getTailwindBorderTopColor() =>
      _getTailwindClass(borderTopColor, _CssColorProperty.borderTopColor) ?? '';
  String getBorderTopColorCss() =>
      _getCssValue(borderTopColor, _CssColorProperty.borderTopColor) ?? '';
}

mixin BorderRightColorMixin on BaseColorPropertyMixin {
  Color? borderRightColor;

  String getTailwindBorderRightColor() =>
      _getTailwindClass(borderRightColor, _CssColorProperty.borderRightColor) ??
      '';
  String getBorderRightColorCss() =>
      _getCssValue(borderRightColor, _CssColorProperty.borderRightColor) ?? '';
}

mixin BorderBottomColorMixin on BaseColorPropertyMixin {
  Color? borderBottomColor;

  String getTailwindBorderBottomColor() =>
      _getTailwindClass(
          borderBottomColor, _CssColorProperty.borderBottomColor) ??
      '';
  String getBorderBottomColorCss() =>
      _getCssValue(borderBottomColor, _CssColorProperty.borderBottomColor) ??
      '';
}

mixin BorderLeftColorMixin on BaseColorPropertyMixin {
  Color? borderLeftColor;

  String getTailwindBorderLeftColor() =>
      _getTailwindClass(borderLeftColor, _CssColorProperty.borderLeftColor) ??
      '';
  String getBorderLeftColorCss() =>
      _getCssValue(borderLeftColor, _CssColorProperty.borderLeftColor) ?? '';
}

mixin OutlineColorMixin on BaseColorPropertyMixin {
  Color? outlineColor;

  String getTailwindOutlineColor() =>
      _getTailwindClass(outlineColor, _CssColorProperty.outlineColor) ?? '';
  String getOutlineColorCss() =>
      _getCssValue(outlineColor, _CssColorProperty.outlineColor) ?? '';
}

mixin CaretColorMixin on BaseColorPropertyMixin {
  Color? caretColor;

  String getTailwindCaretColor() =>
      _getTailwindClass(caretColor, _CssColorProperty.caretColor) ?? '';
  String getCaretColorCss() =>
      _getCssValue(caretColor, _CssColorProperty.caretColor) ?? '';
}

mixin TextDecorationColorMixin on BaseColorPropertyMixin {
  Color? textDecorationColor;

  String getTailwindTextDecorationColor() =>
      _getTailwindClass(
          textDecorationColor, _CssColorProperty.textDecorationColor) ??
      '';
  String getTextDecorationColorCss() =>
      _getCssValue(
          textDecorationColor, _CssColorProperty.textDecorationColor) ??
      '';
}

mixin TextEmphasisColorMixin on BaseColorPropertyMixin {
  Color? textEmphasisColor;

  String getTailwindTextEmphasisColor() =>
      _getTailwindClass(
          textEmphasisColor, _CssColorProperty.textEmphasisColor) ??
      '';
  String getTextEmphasisColorCss() =>
      _getCssValue(textEmphasisColor, _CssColorProperty.textEmphasisColor) ??
      '';
}

mixin ColumnRuleColorMixin on BaseColorPropertyMixin {
  Color? columnRuleColor;

  String getTailwindColumnRuleColor() =>
      _getTailwindClass(columnRuleColor, _CssColorProperty.columnRuleColor) ??
      '';
  String getColumnRuleColorCss() =>
      _getCssValue(columnRuleColor, _CssColorProperty.columnRuleColor) ?? '';
}

mixin AccentColorMixin on BaseColorPropertyMixin {
  Color? accentColor;

  String getTailwindAccentColor() =>
      _getTailwindClass(accentColor, _CssColorProperty.accentColor) ?? '';
  String getAccentColorCss() =>
      _getCssValue(accentColor, _CssColorProperty.accentColor) ?? '';
}

// Non-standard scrollbar colors. Tailwind does not have direct classes for these.
// The Tailwind class names here are illustrative and might not exist.
// You'll likely need custom CSS or browser-specific styling for these.
mixin ScrollbarColorMixin on BaseColorPropertyMixin {
  Color? scrollbarColor;
  Color? scrollbarTrackColor;

  String getTailwindScrollbarColor() =>
      _getTailwindClass(scrollbarColor, _CssColorProperty.scrollbarColor) ?? '';
  String getScrollbarColorCss() =>
      _getCssValue(scrollbarColor, _CssColorProperty.scrollbarColor) ?? '';

  String getTailwindScrollbarTrackColor() =>
      _getTailwindClass(
          scrollbarTrackColor, _CssColorProperty.scrollbarTrackColor) ??
      '';
  String getScrollbarTrackColorCss() =>
      _getCssValue(
          scrollbarTrackColor, _CssColorProperty.scrollbarTrackColor) ??
      '';
}
