import 'package:jaspr/jaspr.dart';

/// Represents a background decoration for a box.
///
/// Mimics Flutter's [BoxDecoration].
///
/// Currently supports color, border, and border radius.
/// More complex decorations like gradients, images, and advanced shadows
/// would require more sophisticated CSS property mapping or custom raw styles.
class BoxDecoration {
  final Color? color;
  final Border? border; // Applies to all sides
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow; // Jaspr's css.dart already has BoxShadow

  const BoxDecoration({
    this.color,
    this.border,
    this.borderRadius,
    this.boxShadow, // Direct use of Jaspr's BoxShadow
  });
}
