import 'package:jaspr/jaspr.dart';

import 'text.dart';
import 'text_span.dart';

/// A Jaspr component that displays text that uses multiple styles.
///
/// The text is laid out in a single line, but can be split into multiple
/// segments, each with its own style.
///
/// Mimics Flutter's [RichText].
class RichText extends StatelessComponent {
  /// The text to display, as a tree of [TextSpan]s.
  final TextSpan content;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to textSpan,
  /// when used in conjunction with [overflow].
  final int? maxLines;

  /// An optional text direction (e.g., LTR or RTL).
  final TextDirection? textDirection;

  const RichText({
    super.key,
    required this.content,
    this.textAlign,
    this.softWrap = true, // Default to true for RichText
    this.overflow = TextOverflow.clip, // Default to clip for RichText
    this.maxLines,
    this.textDirection,
  });

  // Helper method to recursively build components from TextSpan tree
  Iterable<Component> _buildTextSpanComponents(TextSpan textSpan) sync* {
    final Map<String, String> textSpanCssProperties = {};

    // Apply the style of the current textSpan
    if (textSpan.style != null) {
      textSpanCssProperties.addAll(textSpan.style!.toCssMap());
    }

    // Yield the text of the current textSpan within a styled <textSpan>
    if (textSpan.text != null && textSpan.text!.isNotEmpty) {
      yield span(
        styles: Styles(raw: textSpanCssProperties),
        [text(textSpan.text!)],
      );
    }

    // Recursively build children textSpans
    if (textSpan.children != null) {
      for (final childSpan in textSpan.children!) {
        yield* _buildTextSpanComponents(childSpan);
      }
    }
  }

  @override
  build(BuildContext context) sync* {
    final Map<String, String> containerCssProperties = {};

    // Handle textAlign for the entire block
    if (textAlign != null) {
      containerCssProperties['text-align'] = textAlign!.value;
    }
    if (textDirection != null) {
      containerCssProperties['direction'] = textDirection!.name;
    }

    // Handle softWrap for the entire block
    if (softWrap == false) {
      containerCssProperties['white-space'] = WhiteSpace.noWrap.value;
    } else if (softWrap == true) {
      containerCssProperties['white-space'] = WhiteSpace.normal.value;
    }

    // Handle overflow and maxLines for the entire block (crucial for multi-line ellipsis)
    if (overflow != null || maxLines != null) {
      containerCssProperties['overflow'] = 'hidden';

      if (maxLines != null && maxLines! > 0) {
        containerCssProperties['display'] = '-webkit-box';
        containerCssProperties['-webkit-line-clamp'] = maxLines!.toString();
        containerCssProperties['-webkit-box-orient'] = 'vertical';
        containerCssProperties['white-space'] =
            WhiteSpace.normal.value; // Essential for line clamping

        if (overflow == TextOverflow.ellipsis) {
          containerCssProperties['text-overflow'] = TextOverflow.ellipsis.value;
        }
      } else if (overflow == TextOverflow.ellipsis) {
        containerCssProperties['white-space'] = WhiteSpace.noWrap.value;
        containerCssProperties['text-overflow'] = TextOverflow.ellipsis.value;
      } else if (overflow == TextOverflow.clip) {
        containerCssProperties['text-overflow'] = TextOverflow.clip.value;
      }
    }

    yield span(
      // Use a 'textSpan' as the primary container for rich text
      styles: Styles(raw: containerCssProperties),
      [
        // Recursively build the text textSpans
        ..._buildTextSpanComponents(content),
      ],
    );
  }
}
