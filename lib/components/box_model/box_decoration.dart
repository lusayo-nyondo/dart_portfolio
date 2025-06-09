import 'package:jaspr/jaspr.dart';

/// Represents a side of a border.
/// Mimics Flutter's [BorderSide].
class BorderSide {
  final Color color;
  final double width;
  final BorderStyle style;

  const BorderSide({
    this.color = const Color('black'),
    this.width = 1.0,
    this.style = BorderStyle.solid,
  });

  static const BorderSide none =
      BorderSide(width: 0.0, style: BorderStyle.none);
}

/// Represents a background decoration for a box.
///
/// Mimics Flutter's [BoxDecoration].
///
/// Currently supports color, border, and border radius.
/// More complex decorations like gradients, images, and advanced shadows
/// would require more sophisticated CSS property mapping or custom raw styles.
class BoxDecoration {
  final Color? color;
  final BorderSide? border; // Applies to all sides
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow; // Jaspr's css.dart already has BoxShadow

  const BoxDecoration({
    this.color,
    this.border,
    this.borderRadius,
    this.boxShadow, // Direct use of Jaspr's BoxShadow
  });
}
