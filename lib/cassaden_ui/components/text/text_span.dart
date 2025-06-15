import '../../theme/text.dart';

/// A run of text with a single style.
///
/// The TextSpan can be given a style (via the [style] argument), and
/// children (via the [children] argument).
///
/// Mimics Flutter's [TextSpan].
class TextSpan {
  /// The text content of this span.
  final String? text;

  /// The style to apply to [text] and its children.
  final TextStyle? style;

  /// The children of this TextSpan, which are themselves TextSpans.
  final List<TextSpan>? children;

  /// Creates a TextSpan with the given properties.
  const TextSpan({
    this.text,
    this.style,
    this.children,
  });
}
