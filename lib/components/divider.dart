import 'package:jaspr/jaspr.dart';

/// A thin horizontal line, with padding on either side.
///
/// In Flutter, a Divider is a horizontal line. For a vertical line, use [VerticalDivider].
class Divider extends StatelessComponent {
  /// The color of the line itself. If null, defaults to a subtle gray.
  final Color? color;

  /// The thickness of the line, in logical pixels.
  final double thickness;

  /// The amount of empty space to indent the divider.
  final double indent;

  /// The amount of empty space to indent the divider from the end.
  final double endIndent;

  /// The height of the divider. This applies to horizontal dividers.
  /// Flutter's Divider uses height to control its overall space,
  /// while thickness controls the line itself. We'll interpret height as margin
  /// and thickness as the actual line height.
  final double height;

  const Divider({
    super.key,
    this.color,
    this.thickness = 1.0, // Default to 1 logical pixel
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.height = 16.0, // Default equivalent to Flutter's 16.0
  });

  @override
  build(BuildContext context) sync* {
    final List<String> classes = [];

    // Base styling for horizontal line
    classes.add('border-0'); // Remove default border
    classes.add('w-full'); // Ensure it spans full width
    classes.add('shrink-0'); // Don't allow it to shrink
    classes.add('grow-0'); // Don't allow it to grow

    // Apply color
    if (color == null) {
      // Default color if none provided, similar to Flutter's default
      classes.add('bg-gray-300');
    }

    yield hr(
      classes: classes.join(' '),
      styles: Styles(
        // --- CORRECTED: Use value.px ---
        height: thickness.px, // thickness maps to height
        backgroundColor: color, // Use Jaspr Color object directly
        margin: Spacing.only(
          top: (height / 2).px,
          bottom: (height / 2).px,
          left: indent.px,
          right: indent.px,
        ),
      ), // hr tag doesn't have children in HTML
    );
  }
}

/// A thin vertical line, with padding on either side.
///
/// In Flutter, a VerticalDivider is a vertical line. For a horizontal line, use [Divider].
class VerticalDivider extends StatelessComponent {
  /// The color of the line itself. If null, defaults to a subtle gray.
  final Color? color;

  /// The thickness of the line, in logical pixels.
  final double thickness;

  /// The amount of empty space to indent the divider.
  final double indent;

  /// The amount of empty space to indent the divider from the end.
  final double endIndent;

  /// The width of the divider. This applies to vertical dividers.
  /// Flutter's VerticalDivider uses width to control its overall space,
  /// while thickness controls the line itself. We'll interpret width as margin
  /// and thickness as the actual line width.
  final double width;

  const VerticalDivider({
    super.key,
    this.color,
    this.thickness = 1.0, // Default to 1 logical pixel
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.width = 16.0, // Default equivalent to Flutter's 16.0
  });

  @override
  build(BuildContext context) sync* {
    final List<String> classes = [];

    // Base styling for vertical line
    classes.add('border-0'); // Remove default border
    classes.add('h-full'); // Ensure it spans full height
    classes.add('shrink-0'); // Don't allow it to shrink
    classes.add('grow-0'); // Don't allow it to grow

    // Apply color
    if (color == null) {
      // Default color if none provided
      classes.add('bg-gray-300');
    }

    yield div(
      // Use a div for vertical divider, as hr is semantic for horizontal rule
      classes: classes.join(' '),
      styles: Styles(
        // --- CORRECTED: Use value.px ---
        width: thickness.px, // thickness maps to width
        backgroundColor: color, // Use Jaspr Color object directly
        margin: Spacing.only(
          left: (width / 2).px,
          right: (width / 2).px,
          top: indent.px,
          bottom: endIndent.px,
        ),
      ),
      [],
    );
  }
}
