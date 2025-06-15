import 'package:jaspr/jaspr.dart';

import 'clip.dart';

import 'custom_clipper.dart';

import '../../containers/box_model/size.dart';
import '../../containers/box_model/rect.dart';

import '../../extensions/units.dart';

/// A component that clips its child using an oval.
class ClipOval extends StatelessComponent {
  final Component child;
  final CustomClipper<Rect>?
      clipper; // ClipOval uses CustomClipper<Rect> in Flutter
  final Clip clipBehavior;

  const ClipOval({
    required this.child,
    this.clipper,
    this.clipBehavior = Clip.antiAlias, // Default for ClipOval in Flutter
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    Map<String, String> clipStyles = {};

    if (clipBehavior == Clip.none) {
      // No clipping
    } else {
      // Default oval clip
      String clipPathValue = 'ellipse(50% 50% at 50% 50%)';

      if (clipper != null) {
        // If a custom clipper is provided, it defines the Rect.
        // We'll then map this Rect to an ellipse in the clip-path.
        final dummySize = Size(200.px, 200.px); // Placeholder for actual size
        final clipRect = clipper!.getClip(dummySize);

        final centerX = clipRect.left + (clipRect.width / 2).px;
        final centerY = clipRect.top + (clipRect.height / 2).px;
        final radiusX = clipRect.width / 2;
        final radiusY = clipRect.height / 2;

        // Using percentage for radii and center for responsiveness if possible,
        // otherwise pixel values. Here using absolute for precision.
        clipPathValue =
            'ellipse(${radiusX}px ${radiusY}px at ${centerX}px ${centerY}px)';
      }

      clipStyles['clip-path'] = clipPathValue;

      // Apply clip-behavior specific CSS if possible.
      // For anti-aliasing, clip-path is usually anti-aliased by default.
      // For hardEdge, it's harder to force a jagged edge on ellipse directly.
      // For antiAliasWithSaveLayer, not directly possible with CSS clip-path.
      if (clipBehavior == Clip.hardEdge) {
        // You might need a more advanced technique (e.g., SVG filter)
        // or accept browser's default rendering.
        // CSS shape-rendering: crispEdges is for SVG, not clip-path directly.
      }
    }

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: clipStyles),
      children: [child],
    );
  }
}
