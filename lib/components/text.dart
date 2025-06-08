import 'package:jaspr/jaspr.dart';

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
}

/// A Jaspr component that displays a string of text.
///
/// Mimics Flutter's [Text] widget (renamed to TextComponent to avoid name clash).
class TextComponent extends StatelessComponent {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign; // Jaspr's TextAlign enum
  final TextOverflow? overflow; // Jaspr's TextOverflow enum
  final int? maxLines;
  final bool? softWrap; // Whether text should break at soft line breaks

  const TextComponent(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
  });

  @override
  build(BuildContext context) sync* {
    // 1. Initialize a mutable map to collect all CSS properties
    final Map<String, String> cssProperties = {};

    // 2. Add styles from the provided TextStyle first
    if (style != null) {
      cssProperties.addAll(style!.toCssMap());
    }

    // 3. Conditionally add or override properties based on TextComponent's own parameters

    // Handle textAlign
    if (textAlign != null) {
      cssProperties['text-align'] = textAlign!.value;
    }

    // Handle softWrap
    // Default to normal wrapping if softWrap is true or null
    // If softWrap is explicitly false, set to noWrap
    if (softWrap == false) {
      cssProperties['white-space'] = WhiteSpace.noWrap.value;
    } else {
      cssProperties['white-space'] = WhiteSpace.normal.value;
    }

    // Handle overflow and maxLines
    if (overflow != null || maxLines != null) {
      // If any overflow or maxLines property is set, generally hide overflow by default
      cssProperties['overflow'] = 'hidden';

      if (maxLines != null && maxLines! > 0) {
        // For multi-line ellipsis or clamping, use WebKit properties
        cssProperties['display'] = '-webkit-box';
        cssProperties['-webkit-line-clamp'] =
            maxLines!.toString(); // Needs string
        cssProperties['-webkit-box-orient'] = 'vertical';
        // When using -webkit-line-clamp, white-space must be normal
        cssProperties['white-space'] =
            WhiteSpace.normal.value; // Override for line clamping

        if (overflow == TextOverflow.ellipsis) {
          cssProperties['text-overflow'] = TextOverflow.ellipsis.value;
        }
      } else if (overflow == TextOverflow.ellipsis) {
        // Single-line ellipsis implies no wrapping
        cssProperties['white-space'] = WhiteSpace.noWrap.value;
        cssProperties['text-overflow'] = TextOverflow.ellipsis.value;
      } else if (overflow == TextOverflow.clip) {
        // Just hide overflowing content without ellipsis
        cssProperties['text-overflow'] = TextOverflow.clip.value;
      }
    }

    // 4. Create the final Styles object using the 'raw' parameter of the main constructor
    final Styles finalStyles = Styles(
      raw: cssProperties,
    );

    yield span(
      // Use span for inline text, or p for block text if preferred
      styles: finalStyles,
      [Text(text)], // Correct usage for Jaspr's text node
    );
  }
}
