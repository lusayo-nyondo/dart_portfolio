import 'package:jaspr/jaspr.dart';

import '../../containers/box_model/size.dart';
import 'clip.dart';
import 'custom_clipper.dart';
import '../../containers/box_model/path.dart';

/// A component that clips its child using an arbitrary path.
class ClipPath extends StatelessComponent {
  final CustomClipper<Path> clipper;
  final Component child;
  final Clip clipBehavior;

  const ClipPath({
    required this.clipper,
    required this.child,
    this.clipBehavior = Clip.antiAlias, // Default for ClipPath in Flutter
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    Map<String, String> clipStyles = {};

    if (clipBehavior == Clip.none) {
      // No clipping
    } else {
      // Placeholder: In a real scenario, this 'dummySize' would need to be
      // the actual size of the rendering area for the clipper.
      final dummySize =
          Size(200, 200); // Assume a default or calculate from context
      final path = clipper.getClip(dummySize);

      clipStyles['clip-path'] = 'path("${path.toSvgPathData()}")';

      // Apply clip-behavior specific CSS if possible.
      if (clipBehavior == Clip.hardEdge) {
        // For SVG paths, you can try shape-rendering: crispEdges,
        // but it's not a standard CSS property for clip-path.
        // It's a limitation of direct CSS mapping.
      } else if (clipBehavior == Clip.antiAliasWithSaveLayer) {
        // This is not directly achievable with clip-path.
        // Would require rendering to a canvas or SVG with filters.
      }
    }

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: clipStyles),
      children: [child],
    );
  }
}
