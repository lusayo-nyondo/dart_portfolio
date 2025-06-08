// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:jaspr/jaspr.dart';
import 'box_fit.dart'; // Import BoxFit
import 'align.dart'; // Import Alignment (for child positioning)

/// A widget that scales and positions its child within itself according to a [BoxFit].
///
/// Mimics Flutter's [FittedBox] widget.
///
/// **Important Limitations for arbitrary HTML content:**
/// Flutter's [FittedBox] works by measuring the child's intrinsic size and
/// then applying transformations. In web CSS, `object-fit` and `object-position`
/// provide similar functionality but are primarily designed for "replaced elements"
/// like `<img>` or `<video>`.
///
/// For arbitrary `div`s or other generic HTML elements as children, CSS cannot
/// natively "measure" their intrinsic size and then automatically scale them while
/// respecting `BoxFit` values (like `cover`, `contain`, `fill`) without
/// JavaScript.
///
/// This Jaspr implementation will:
/// 1. Create a container (`div`) with `overflow: hidden`.
/// 2. Use flexbox within the container to apply `alignment` (horizontally and vertically).
/// 3. It **cannot** precisely apply `transform: scale()` or adjust child dimensions
///    to perfectly mimic all `BoxFit` modes for generic HTML children *purely with CSS*.
///    For images/videos, you would typically apply `object-fit` directly to the `<img>`
///    or `<video>` tag itself within the `FittedBox`'s child.
///
/// If precise [BoxFit] behavior for non-image/video children is required,
/// it would necessitate advanced JavaScript interop to measure elements at runtime
/// and then dynamically apply `transform: scale()` to the child.
class FittedBox extends StatelessComponent {
  final Component child;
  final BoxFit fit;
  final Alignment alignment;

  const FittedBox({
    super.key,
    required this.child,
    this.fit = BoxFit.contain, // Default similar to Flutter
    this.alignment = Alignment.center, // Default similar to Flutter
  });

  // Helper to map Alignment to Jaspr's JustifyContent and AlignItems
  JustifyContent _getJustifyContent(Alignment alignment) {
    if (alignment.x < 0) return JustifyContent.start;
    if (alignment.x > 0) return JustifyContent.end;
    return JustifyContent.center;
  }

  AlignItems _getAlignItems(Alignment alignment) {
    if (alignment.y < 0) return AlignItems.start;
    if (alignment.y > 0) return AlignItems.end;
    return AlignItems.center;
  }

  @override
  build(BuildContext context) sync* {
    // These styles will be applied to the inner child wrapper
    Unit? _childWidth;
    Unit? _childHeight;

    // For BoxFit.fill, the child should fill the container
    if (fit == BoxFit.fill) {
      _childWidth = 100.percent;
      _childHeight = 100.percent;
    }
    // For other BoxFit values, the behavior for generic HTML children
    // is largely conceptual and relies on the child's intrinsic size
    // and the flex container's alignment. True scaling without JS is hard.

    yield div(
      classes:
          'w-full h-full overflow-hidden', // Parent container for fitting, clips child
      styles: Styles(
        display: Display.flex, // Enable flexbox for alignment
        justifyContent: _getJustifyContent(alignment),
        alignItems: _getAlignItems(alignment),
      ),
      [
        // The child itself, wrapped in a div that might get specific dimensions for 'fill'
        div(
          styles: Styles(
            width: _childWidth,
            height: _childHeight,
            // If the child is an image or video, you might want to apply object-fit here
            // e.g., objectFit: ObjectFit.cover for BoxFit.cover
          ),
          [child],
        ),
      ],
    );
  }
}
