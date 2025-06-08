part of 'mixins.dart';

enum _CssColorProperty {
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

// Helper function to get Tailwind class name from a Jaspr Color
// This assumes TailwindColor.fromJasprColor can handle standard Jaspr Color
String? _getTailwindClassName(Color color, _CssColorProperty propertyType) {
  if (propertyType.tailwindPrefix == null) {
    return null; // This property doesn't have a direct Tailwind class
  }

  // Ensure your TailwindColor.fromJasprColor method correctly converts
  // a Jaspr Color to your TailwindColor instance, especially for arbitrary values.
  TailwindColor tailwindColor = TailwindColor.fromJasprColor(color);

  // For named CSS colors or arbitrary hex values, use bracket notation.
  // For standard Tailwind colors (like red-500), just append.
  // This logic needs to be robust enough for all cases.
  // Assuming tailwindColor.className already handles this (e.g., 'red-500' or '[#FFD700]')
  return '${propertyType.tailwindPrefix}${tailwindColor.className}';
}

// --- Base Mixin for providing the Collector and Common Logic ---
/// This mixin must be applied to a Jaspr Component and provides
/// access to the [TailwindClassCollector].
///
/// The component must call [initTailwindCollector] in its constructor.
mixin HasTailwindClassCollector on Component {
  /// The collector instance for this specific component.
  TailwindClassCollector get _classCollector;

  /// Internal helper to register a Tailwind class.
  /// All concrete property mixins will use this.
  void _registerTailwindClass(Color? color, _CssColorProperty propertyType) {
    if (color == null) return; // No color, no class to register

    final String? className = _getTailwindClassName(color, propertyType);
    if (className != null && className.isNotEmpty) {
      _classCollector.addClass(className);
    } else {
      // Handle cases where a property has no direct Tailwind class
      // (e.g., scrollbarColor), or if the color itself doesn't map.
      // You might log a warning.
      print(
          'Warning: No Tailwind class generated for ${propertyType.cssName} with color ${color.value}');
    }
  }
}

// --- Concrete Color Property Mixins ---

/// Mixin for handling background color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin BackgroundColorMixin on HasTailwindClassCollector {
  /// The background color for the component.
  Color? get backgroundColor;

  /// **Registers** the appropriate Tailwind CSS background color class
  /// with the component's [TailwindClassCollector].
  /// This method should be called by the component after its constructor.
  void registerBackgroundColorClasses() {
    _registerTailwindClass(backgroundColor, _CssColorProperty.backgroundColor);
  }
}

/// Mixin for handling border color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin BorderColorMixin on HasTailwindClassCollector {
  Color? get borderColor;

  void registerBorderColorClasses() {
    _registerTailwindClass(borderColor, _CssColorProperty.borderColor);
  }
}

/// Mixin for handling border top color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin BorderTopColorMixin on HasTailwindClassCollector {
  Color? get borderTopColor;

  void registerBorderTopColorClasses() {
    _registerTailwindClass(borderTopColor, _CssColorProperty.borderTopColor);
  }
}

/// Mixin for handling border right color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin BorderRightColorMixin on HasTailwindClassCollector {
  Color? get borderRightColor;

  void registerBorderRightColorClasses() {
    _registerTailwindClass(
        borderRightColor, _CssColorProperty.borderRightColor);
  }
}

/// Mixin for handling border bottom color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin BorderBottomColorMixin on HasTailwindClassCollector {
  Color? get borderBottomColor;

  void registerBorderBottomColorClasses() {
    _registerTailwindClass(
        borderBottomColor, _CssColorProperty.borderBottomColor);
  }
}

/// Mixin for handling border left color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin BorderLeftColorMixin on HasTailwindClassCollector {
  Color? get borderLeftColor;

  void registerBorderLeftColorClasses() {
    _registerTailwindClass(borderLeftColor, _CssColorProperty.borderLeftColor);
  }
}

/// Mixin for handling outline color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin OutlineColorMixin on HasTailwindClassCollector {
  Color? get outlineColor;

  void registerOutlineColorClasses() {
    _registerTailwindClass(outlineColor, _CssColorProperty.outlineColor);
  }
}

/// Mixin for handling caret color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin CaretColorMixin on HasTailwindClassCollector {
  Color? get caretColor;

  void registerCaretColorClasses() {
    _registerTailwindClass(caretColor, _CssColorProperty.caretColor);
  }
}

/// Mixin for handling text decoration color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin TextDecorationColorMixin on HasTailwindClassCollector {
  Color? get textDecorationColor;

  void registerTextDecorationColorClasses() {
    _registerTailwindClass(
        textDecorationColor, _CssColorProperty.textDecorationColor);
  }
}

/// Mixin for handling text emphasis color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin TextEmphasisColorMixin on HasTailwindClassCollector {
  Color? get textEmphasisColor;

  void registerTextEmphasisColorClasses() {
    _registerTailwindClass(
        textEmphasisColor, _CssColorProperty.textEmphasisColor);
  }
}

/// Mixin for handling column rule color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin ColumnRuleColorMixin on HasTailwindClassCollector {
  Color? get columnRuleColor;

  void registerColumnRuleColorClasses() {
    _registerTailwindClass(columnRuleColor, _CssColorProperty.columnRuleColor);
  }
}

/// Mixin for handling accent color.
/// Requires [HasTailwindClassCollector] to be mixed in before it.
mixin AccentColorMixin on HasTailwindClassCollector {
  Color? get accentColor;

  void registerAccentColorClasses() {
    _registerTailwindClass(accentColor, _CssColorProperty.accentColor);
  }
}

// --- Special Cases: Scrollbar Colors ---
// Tailwind does not have direct utility classes for scrollbar-color.
// The register methods here will only add a class if a tailwindPrefix is defined
// for the corresponding _CssColorProperty. If not, a warning is printed.
mixin ScrollbarColorMixin on HasTailwindClassCollector {
  Color? get scrollbarColor;
  Color? get scrollbarTrackColor;

  void registerScrollbarColorClasses() {
    _registerTailwindClass(scrollbarColor, _CssColorProperty.scrollbarColor);
  }

  void registerScrollbarTrackColorClasses() {
    _registerTailwindClass(
        scrollbarTrackColor, _CssColorProperty.scrollbarTrackColor);
  }
}
