import 'package:jaspr/jaspr.dart';

/// An abstract class representing a 2D alignment.
///
/// Values range from -1.0 (left/top) to 1.0 (right/bottom).
/// For example, `Alignment(-1.0, -1.0)` is `topLeft`, and `Alignment(0.0, 0.0)` is `center`.
class Alignment {
  final double x;
  final double y;

  const Alignment(this.x, this.y);

  static const Alignment topLeft = Alignment(-1.0, -1.0);
  static const Alignment topCenter = Alignment(0.0, -1.0);
  static const Alignment topRight = Alignment(1.0, -1.0);
  static const Alignment centerLeft = Alignment(-1.0, 0.0);
  static const Alignment center = Alignment(0.0, 0.0);
  static const Alignment centerRight = Alignment(1.0, 0.0);
  static const Alignment bottomLeft = Alignment(-1.0, 1.0);
  static const Alignment bottomCenter = Alignment(0.0, 1.0);
  static const Alignment bottomRight = Alignment(1.0, 1.0);
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
