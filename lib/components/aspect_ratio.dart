import 'package:jaspr/jaspr.dart';

/// A widget that attempts to size its child to a specific aspect ratio.
///
/// Mimics Flutter's [AspectRatio] widget.
///
/// This widget will size itself to be as large as possible without violating
/// its aspect ratio or its parent's constraints. Its child will then fill
/// this constrained space.
class AspectRatio extends StatelessComponent {
  final Component child;
  final double aspectRatio;

  const AspectRatio({
    super.key,
    required this.child,
    this.aspectRatio = 1.0, // Default to a 1:1 square
  });

  @override
  build(BuildContext context) sync* {
    // The CSS aspect ratio trick: using padding-bottom as a percentage of the width
    // to control the height and maintain the aspect ratio.
    // Calculation: (height / width) * 100% = (1 / aspectRatio) * 100%
    final double paddingBottomPercent = (1 / aspectRatio) * 100;

    yield div(
      classes:
          'relative w-full', // Take full width, and set up for absolute positioning of child
      styles: Styles(
        padding: Spacing.only(
            bottom: paddingBottomPercent
                .percent), // The core of the aspect ratio magic
      ),
      [
        // The actual child, absolutely positioned to fill the space defined by the padding
        div(
          classes:
              'absolute top-0 left-0 w-full h-full', // Child fills the container
          [child],
        ),
      ],
    );
  }
}
