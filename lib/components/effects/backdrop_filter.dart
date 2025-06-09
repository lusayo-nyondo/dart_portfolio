import 'package:jaspr/jaspr.dart';

import 'clips/clip.dart';
import 'image_filter.dart';

/// A component that applies a filter to the content layered behind its child.
/// This is typically used for effects like frosted glass.
class BackdropFilter extends StatelessComponent {
  final ImageFilter filter;
  final Component child;

  /// The clip behavior for the filter. This applies to the shape of the
  /// filter area.
  /// Note: `Clip.hardEdge` and `Clip.antiAliasWithSaveLayer` might not
  /// be perfectly replicable using CSS `backdrop-filter` alone.
  final Clip clipBehavior;

  const BackdropFilter({
    required this.filter,
    required this.child,
    this.clipBehavior =
        Clip.none, // Default to Clip.none for BackdropFilter in Flutter
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Base styles for the backdrop filter container
    final Map<String, String> containerStyles = {
      'position':
          'relative', // Essential for stacking context and positioning child
      // Creating a stacking context for backdrop-filter to work
      // Often, a transform or z-index is needed.
      'transform':
          'translateZ(0)', // A common trick to force a new stacking context
      '-webkit-transform': 'translateZ(0)', // For older Safari
      'z-index':
          '1', // Ensure it's above other elements if needed, but not necessarily below them
    };

    // Apply clip-path if clipBehavior is not none.
    // backdrop-filter itself doesn't have a clip-behavior, but the element it's applied to can be clipped.
    // For this, we'll apply the clip-path to the backdrop-filter div itself.
    // Note: We don't have a `CustomClipper` for `BackdropFilter` directly in Flutter,
    // the clipping is typically done by the parent that defines the boundary.
    // For simplicity here, we'll just apply a rectangular clip if requested.
    if (clipBehavior != Clip.none) {
      // For rectangular clips, `overflow: hidden` on the container can work,
      // but `backdrop-filter` applies to the element itself, so `clip-path` is more direct.
      // If we had a clipper, we'd use it here.
      // As BackdropFilter in Flutter implicitly clips to its own bounds,
      // a simple rectangular clip to its own bounds is often what's implied.
      containerStyles['overflow'] = 'hidden'; // For rectangular clip
      // For non-rectangular clips, `clip-path` would be needed,
      // but `BackdropFilter` doesn't take a `clipper` in Flutter.
    }

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: containerStyles),
      children: [
        // The element that will have the backdrop-filter applied.
        // It needs to be positioned over the content it wants to filter.
        DomComponent(
          tag: 'div',
          classes: 'jaspr-backdrop-filter-layer',
          styles: Styles(raw: {
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'width': '100%',
            'height': '100%',
            // Apply the actual backdrop filter
            'backdrop-filter': filter.toCssFilter(),
            '-webkit-backdrop-filter':
                filter.toCssFilter(), // For Webkit browsers
          }),
        ),
        // The actual child content of the BackdropFilter widget
        child,
      ],
    );
  }
}

// Dummy Color class (if not already defined)
class Color {
  final String value;
  const Color(this.value);
  static const black = Color('black');
  static const white = Color('white');
  static const blue = Color('blue');

  @override
  bool operator ==(Object other) => other is Color && value == other.value;
  @override
  int get hashCode => value.hashCode;
}

// Example Usage (imagine a background element is present):
//
// RootComponent(
//   children: [
//     // Some background content
//     DomComponent(
//       tag: 'div',
//       style: Styles.raw({
//         'position': 'absolute',
//         'top': '0',
//         'left': '0',
//         'width': '100%',
//         'height': '100%',
//         'background': 'linear-gradient(to right, #ff0000, #0000ff)',
//       }),
//     ),
//     Center(
//       child: Container(
//         width: 200,
//         height: 200,
//         color: Color('rgba(255, 255, 255, 0.3)'), // Semi-transparent background for frosted glass effect
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//           clipBehavior: Clip.hardEdge, // If you want the blur to be clipped to the container's bounds
//           child: Center(
//             child: Text(
//               'Frosted Glass',
//               style: Styles.text(color: Color.black, fontSize: 24.px),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// )
