import 'package:jaspr/jaspr.dart';

// lib/components/styles/alignment.dart

/// How a child is aligned within its parent.
///
/// Mimics Flutter's [Alignment] using `x` and `y` coordinates
/// ranging from -1.0 (start) to 1.0 (end).
///
/// Provides getters to produce CSS values for various alignment properties,
/// covering single-item positioning (e.g., `object-position`),
/// Flexbox alignment (`justify-content`, `align-items`, `align-content`),
/// and Grid alignment (`justify-items`).
class Alignment {
  final double x; // -1.0 (left/start) to 1.0 (right/end)
  final double y; // -1.0 (top/start) to 1.0 (bottom/end)

  const Alignment(this.x, this.y);

  // Standard Flutter-like Alignment constants
  static const Alignment topLeft = Alignment(-1.0, -1.0);
  static const Alignment topCenter = Alignment(0.0, -1.0);
  static const Alignment topRight = Alignment(1.0, -1.0);
  static const Alignment centerLeft = Alignment(-1.0, 0.0);
  static const Alignment center = Alignment(0.0, 0.0);
  static const Alignment centerRight = Alignment(1.0, 0.0);
  static const Alignment bottomLeft = Alignment(-1.0, 1.0);
  static const Alignment bottomCenter = Alignment(0.0, 1.0);
  static const Alignment bottomRight = Alignment(1.0, 1.0);

  /// Returns the CSS value for properties like `object-position` or `background-position`.
  ///
  /// Maps `x` and `y` from `[-1.0, 1.0]` to `[0%, 100%]`.
  /// Uses keywords (`left`, `center`, `right`, `top`, `bottom`) for exact values
  /// and percentages (`xx.x%`) for intermediate values.
  ///
  /// Examples: 'left top', 'center', '50.0% 75.0%'.
  String get objectPositionCssString {
    final double xPercentage = (x + 1.0) / 2.0 * 100.0;
    final double yPercentage = (y + 1.0) / 2.0 * 100.0;

    String xPart;
    if (x == -1.0) {
      xPart = 'left';
    } else if (x == 0.0) {
      xPart = 'center';
    } else if (x == 1.0) {
      xPart = 'right';
    } else {
      xPart = '${xPercentage.toStringAsFixed(1)}%';
    }

    String yPart;
    if (y == -1.0) {
      yPart = 'top';
    } else if (y == 0.0) {
      yPart = 'center';
    } else if (y == 1.0) {
      yPart = 'bottom';
    } else {
      yPart = '${yPercentage.toStringAsFixed(1)}%';
    }

    if (xPart == 'center' && yPart == 'center') {
      return 'center';
    }

    return '$xPart $yPart';
  }

  /// Returns the CSS `justify-content` property value.
  ///
  /// This is suitable for **horizontal alignment** of items within a Flex container
  /// (along the main axis when `flex-direction` is `row`).
  ///
  /// Maps `x` to `flex-start` (`-1.0`), `center` (`0.0`), or `flex-end` (`1.0`).
  /// Intermediate `x` values are mapped to 'center' as `justify-content`
  /// does not accept percentage values for individual item positioning.
  String get justifyContentCssString {
    if (x == -1.0) {
      return 'flex-start';
    } else if (x == 0.0) {
      return 'center';
    } else if (x == 1.0) {
      return 'flex-end';
    } else {
      return 'center'; // Sensible default for non-exact values in flexbox justify-content
    }
  }

  /// Returns the CSS `align-items` property value.
  ///
  /// This is suitable for **vertical alignment** of items within a Flex container
  /// (along the cross axis when `flex-direction` is `row`).
  ///
  /// Maps `y` to `flex-start` (`-1.0`), `center` (`0.0`), or `flex-end` (`1.0`).
  /// Intermediate `y` values are mapped to 'center' as `align-items`
  /// does not accept percentage values for individual item positioning.
  String get alignItemsCssString {
    if (y == -1.0) {
      return 'flex-start';
    } else if (y == 0.0) {
      return 'center';
    } else if (y == 1.0) {
      return 'flex-end';
    } else {
      return 'center'; // Sensible default for non-exact values in flexbox align-items
    }
  }

  /// Returns the CSS `justify-items` property value.
  ///
  /// This is primarily used for **Grid containers** to align grid items
  /// within their grid areas along the inline (row) axis.
  ///
  /// Maps `x` to `start` (`-1.0`), `center` (`0.0`), or `end` (`1.0`).
  /// Intermediate `x` values are mapped to 'center'.
  String get justifyItemsCssString {
    if (x == -1.0) {
      return 'start';
    } else if (x == 0.0) {
      return 'center';
    } else if (x == 1.0) {
      return 'end';
    } else {
      return 'center'; // Sensible default for non-exact values in grid justify-items
    }
  }

  /// Returns the CSS `align-content` property value.
  ///
  /// This is suitable for **Flex containers with `flex-wrap: wrap`** when
  /// there are multiple lines of flex items, aligning the lines themselves
  /// along the cross axis.
  ///
  /// Maps `y` to `flex-start` (`-1.0`), `center` (`0.0`), or `flex-end` (`1.0`).
  /// Intermediate `y` values are mapped to 'center'.
  /// Note: `align-content` also has values like `space-between`, `space-around`,
  /// and `stretch` which are not directly representable by a single `y` coordinate
  /// from this `Alignment` model.
  String get alignContentCssString {
    if (y == -1.0) {
      return 'flex-start';
    } else if (y == 0.0) {
      return 'center';
    } else if (y == 1.0) {
      return 'flex-end';
    } else {
      return 'center'; // Sensible default for non-exact values in flexbox align-content
    }
  }

  /// Provides a string representation of the Alignment's coordinates.
  @override
  String toString() =>
      'Alignment(x: ${x.toStringAsFixed(1)}, y: ${y.toStringAsFixed(1)})';

  /// Provides the primary CSS string representation for this Alignment.
  /// Defaults to the format for `object-position` or `background-position`.
  String toCssString() => objectPositionCssString;
}

/// A widget that aligns its child within itself.
///
/// Mimics Flutter's [Align] widget.
///
/// By default, it expands to take up all available space.
///
/// **Note on `widthFactor` and `heightFactor`:**
/// Flutter's [Align] widget can size itself to a multiple of its child's size
/// using `widthFactor` and `heightFactor`. This functionality is complex
/// to replicate precisely with pure CSS without JavaScript to measure the child's
/// intrinsic dimensions dynamically.
///
/// In this Jaspr implementation, if `widthFactor` or `heightFactor` are provided,
/// the [Align] component will attempt to shrink-wrap its content (becoming
/// only as large as its child) and then position the child. The direct
/// multiplication/scaling behavior based on the factor is not applied purely
/// via CSS, as it requires knowledge of the child's exact rendered size.
class Align extends StatelessComponent {
  final Component child;
  final Alignment alignment;
  final double? widthFactor;
  final double? heightFactor;

  const Align({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
  });

  // Helper to map Alignment to Tailwind flex classes for horizontal alignment
  String _getJustifyContentClass(Alignment alignment) {
    if (alignment.x < 0) return 'justify-start';
    if (alignment.x > 0) return 'justify-end';
    return 'justify-center';
  }

  // Helper to map Alignment to Tailwind flex classes for vertical alignment
  String _getAlignItemsClass(Alignment alignment) {
    if (alignment.y < 0) return 'items-start';
    if (alignment.y > 0) return 'items-end';
    return 'items-center';
  }

  @override
  build(BuildContext context) sync* {
    final List<String> classes = ['flex']; // Enable flexbox

    // Apply classes for horizontal and vertical alignment
    classes.add(_getJustifyContentClass(alignment));
    classes.add(_getAlignItemsClass(alignment));

    // Handle sizing based on factors or default expansion
    if (widthFactor != null || heightFactor != null) {
      // If factors are provided, try to make the Align container shrink-wrap its child.
      // This makes it only as large as its content, not a multiple of it.
      classes.add(
          'inline-flex'); // Allows the flex container to shrink-wrap content
      classes.add('max-w-max'); // Ensure it shrinks horizontally
      classes.add('max-h-max'); // Ensure it shrinks vertically
    } else {
      // By default, Align expands to fill available space
      classes.add('w-full');
      classes.add('h-full');
    }

    yield div(
      classes: classes.join(' '),
      [child],
    );
  }
}
