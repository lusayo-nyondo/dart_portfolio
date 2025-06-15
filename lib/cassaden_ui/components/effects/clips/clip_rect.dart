import 'package:jaspr/jaspr.dart';

import 'custom_clipper.dart';
import 'clip.dart';

import '../../containers/box_model/size.dart';
import '../../containers/box_model/rect.dart';
import '../../extensions/units.dart';

/// A component that clips its child using a rectangle.
class ClipRect extends StatelessComponent {
  final Component child;
  final CustomClipper<Rect>? clipper;
  final Clip clipBehavior;

  const ClipRect({
    required this.child,
    this.clipper,
    this.clipBehavior = Clip.hardEdge, // Default for ClipRect in Flutter
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Determine clipping style based on clipBehavior
    Map<String, String> clipStyles = {};
    if (clipBehavior == Clip.none) {
      clipStyles['overflow'] = 'visible';
    } else {
      // For rectangular clipping, overflow: hidden is generally sufficient
      // and behaves like Clip.hardEdge.
      // For antiAlias, we might need a more complex solution if precise
      // anti-aliasing is needed for a simple rect, but typically overflow:hidden
      // works well.
      clipStyles['overflow'] = 'hidden';

      if (clipper != null) {
        // If a custom clipper is provided, we need to apply clip-path.
        // This is a bit more complex for ClipRect, as CustomClipper<Rect>
        // implies a specific rect, not just the bounding box.
        // For accurate emulation, we'd need to precisely size the parent
        // div and then use clip-path to define the custom rect.
        // For simplicity here, we'll assume the clipper defines the clip
        // relative to the container's bounds, similar to ClipPath.
        // A more robust solution might involve an SVG clipPath.

        // Placeholder: In a real scenario, this 'dummySize' would need to be
        // the actual size of the rendering area for the clipper.
        final dummySize =
            Size(200.px, 200.px); // Assume a default or calculate from context
        final clipRect = clipper!.getClip(dummySize);

        // This CSS clip-path assumes the clipped content is within the parent.
        // For precise Flutter Rect clipping, you might need to combine this
        // with absolute positioning of the child within the clipped div.
        clipStyles['clip-path'] =
            'inset(${clipRect.top}px ${dummySize.width - clipRect.right}px ${dummySize.height - clipRect.bottom}px ${clipRect.left}px)';
        // For Clip.antiAlias or Clip.antiAliasWithSaveLayer, we rely on browser's
        // default anti-aliasing for inset(), or would need to use SVG clipPath
        // with shape-rendering property.
        if (clipBehavior == Clip.antiAlias ||
            clipBehavior == Clip.antiAliasWithSaveLayer) {
          // Browsers typically anti-alias clip-path by default.
          // To get "hardEdge" specifically, one might look into SVG clipPath with shape-rendering.
          // CSS filter: blur(0.5px) could add anti-aliasing post-clipping, but that's a hack.
        }
      }
    }

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: clipStyles),
      children: [child],
    );
  }
}
