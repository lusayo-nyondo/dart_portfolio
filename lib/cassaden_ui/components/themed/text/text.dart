import 'package:jaspr/jaspr.dart';

import '../../../theme/text.dart';
export 'text_span.dart';
export 'rich_text.dart';

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

class DefaultTextStyle extends StatelessComponent {
  /// The style to apply to descendant text.
  final TextStyle style;

  /// How the text should be aligned.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span,
  /// when used in conjunction with [overflow].
  final int? maxLines;

  /// The widget below this widget in the tree.
  final Component child;

  const DefaultTextStyle({
    super.key,
    required this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    required this.child,
  });

  @override
  build(BuildContext context) sync* {
    // Collect all CSS properties, similar to TextComponent
    final Map<String, String> cssProperties = {};

    // Add base style properties
    cssProperties.addAll(style.toCssMap());

    // Handle textAlign
    if (textAlign != null) {
      cssProperties['text-align'] = textAlign!.value;
    }

    // Handle softWrap
    if (softWrap == false) {
      cssProperties['white-space'] = WhiteSpace.noWrap.value;
    } else if (softWrap == true) {
      cssProperties['white-space'] = WhiteSpace.normal.value;
    }

    // Handle overflow and maxLines.
    // Note: Line clamping (-webkit-line-clamp) often needs to be on the
    // element directly containing the text/spans, not just inherited.
    // So, while we'll set it here, TextComponent will also handle it for itself.
    // This DefaultTextStyle mostly covers inheritable text properties.
    if (overflow != null || maxLines != null) {
      cssProperties['overflow'] = 'hidden';

      if (maxLines != null && maxLines! > 0) {
        cssProperties['display'] = '-webkit-box';
        cssProperties['-webkit-line-clamp'] = maxLines!.toString();
        cssProperties['-webkit-box-orient'] = 'vertical';
        cssProperties['white-space'] = WhiteSpace.normal.value;

        if (overflow == TextOverflow.ellipsis) {
          cssProperties['text-overflow'] = TextOverflow.ellipsis.value;
        }
      } else if (overflow == TextOverflow.ellipsis) {
        cssProperties['white-space'] = WhiteSpace.noWrap.value;
        cssProperties['text-overflow'] = TextOverflow.ellipsis.value;
      } else if (overflow == TextOverflow.clip) {
        cssProperties['text-overflow'] = TextOverflow.clip.value;
      }
    }

    yield span(
      // Use a span or div as the container for inheritance
      styles: Styles(raw: cssProperties),
      [child],
    );
  }
}
