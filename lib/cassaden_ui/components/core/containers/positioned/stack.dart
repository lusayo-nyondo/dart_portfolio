// lib/components/layout/stack.dart

import 'package:jaspr/jaspr.dart';

import '../align.dart';
import '../../effects/clips/clip.dart';
import 'positioned.dart';

/// How a non-positioned child of a [Stack] will be sized.
///
/// Mimics Flutter's [StackFit].
enum StackFit {
  /// The non-positioned children are allowed to have their own size.
  /// They will not be forced to expand to fill the stack.
  loose,

  /// The non-positioned children are forced to expand to fill the stack.
  /// This will usually result in `width: 100%; height: 100%;` for such children.
  expand,
}

/// A widget that positions its children relative to its edges.
///
/// This widget allows you to layer multiple children on top of each other.
/// Children can be explicitly positioned using [Positioned] widgets.
/// Unpositioned children will default to being aligned to the top-left corner
/// of the stack.
///
/// It translates to a `div` with `position: relative`.
class Stack extends StatelessComponent {
  /// How the non-positioned children of the stack are aligned.
  ///
  /// This controls where children are placed if they are not wrapped in
  /// [Positioned] widgets.
  final Alignment alignment;

  /// The text direction to resolve the `alignment` property.
  /// (Currently not fully implemented in CSS mapping, mainly for conceptual parity).
  // final TextDirection? textDirection; // Consider adding TextDirection enum if needed

  /// How the non-positioned children of the stack are sized.
  ///
  /// If [StackFit.loose], non-positioned children are allowed to size
  /// themselves. If [StackFit.expand], they are forced to expand to fill the
  /// stack.
  final StackFit fit;

  /// How the stack's children are clipped.
  ///
  /// Corresponds to the CSS `overflow` property.
  final Clip clipBehavior;

  /// The list of children to layer.
  final List<Component> children;

  const Stack({
    super.key,
    this.alignment = Alignment.topLeft, // Default Flutter alignment
    // this.textDirection, // Not mapping textDirection directly to CSS yet for simplicity
    this.fit = StackFit.loose, // Default Flutter fit
    this.clipBehavior = Clip.hardEdge, // Default Flutter clip
    this.children = const [],
  });

  // Helper to map Clip enum to CSS overflow property
  String _mapClipBehaviorToOverflow(Clip clip) {
    switch (clip) {
      case Clip.none:
        return 'visible';
      case Clip.hardEdge:
      case Clip.antiAlias:
      case Clip.antiAliasWithSaveLayer:
        // These Flutter clips generally correspond to CSS 'hidden' for basic clipping
        return 'hidden';
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final String overflowValue = _mapClipBehaviorToOverflow(clipBehavior);

    yield div(
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%', // By default, stacks expand to fill parent width
        'height': '100%', // And height.
        'overflow': overflowValue, // Apply clipping
      }),
      children.map((child) {
        // If the child is a Positioned component, render it directly.
        // It already handles its own absolute positioning.
        if (child is Positioned) {
          return child;
        }

        // If the child is not a Positioned component, it's an "unpositioned" child.
        // We need to apply StackFit and Alignment to it.
        // This is where it gets tricky to perfectly mimic Flutter with raw CSS.
        // For unpositioned children, we can make them absolutely positioned implicitly
        // and then apply styling to achieve the desired alignment/fit.
        final Map<String, String> unpositionedChildStyles = {
          'position':
              'absolute', // Unpositioned children effectively become absolute
        };

        // Apply StackFit.expand logic
        if (fit == StackFit.expand) {
          unpositionedChildStyles['width'] = '100%';
          unpositionedChildStyles['height'] = '100%';
          unpositionedChildStyles['left'] = '0';
          unpositionedChildStyles['top'] = '0';
          unpositionedChildStyles['right'] = '0';
          unpositionedChildStyles['bottom'] = '0';
        }

        // Apply alignment for unpositioned children.
        // This needs to be done using top/left/right/bottom and transforms for actual positioning.
        // A simple way is to use `margin: auto` when paired with explicit dimensions.
        // However, for generic alignment of content-sized blocks, a flex/grid setup in a wrapper is better.
        // For now, we'll try to apply direct positioning where possible.
        // More precise alignment for unpositioned children in CSS is typically done via
        // `top: X%, left: Y%` and then `transform: translate(-X%, -Y%)`.
        // Let's implement common alignments for non-positioned children:
        if (alignment == Alignment.center) {
          unpositionedChildStyles['top'] = '50%';
          unpositionedChildStyles['left'] = '50%';
          unpositionedChildStyles['transform'] = 'translate(-50%, -50%)';
        } else if (alignment == Alignment.topLeft) {
          unpositionedChildStyles['top'] = '0';
          unpositionedChildStyles['left'] = '0';
        } else if (alignment == Alignment.topCenter) {
          unpositionedChildStyles['top'] = '0';
          unpositionedChildStyles['left'] = '50%';
          unpositionedChildStyles['transform'] = 'translateX(-50%)';
        } else if (alignment == Alignment.topRight) {
          unpositionedChildStyles['top'] = '0';
          unpositionedChildStyles['right'] = '0';
        } else if (alignment == Alignment.centerLeft) {
          unpositionedChildStyles['top'] = '50%';
          unpositionedChildStyles['left'] = '0';
          unpositionedChildStyles['transform'] = 'translateY(-50%)';
        } else if (alignment == Alignment.centerRight) {
          unpositionedChildStyles['top'] = '50%';
          unpositionedChildStyles['right'] = '0';
          unpositionedChildStyles['transform'] = 'translateY(-50%)';
        } else if (alignment == Alignment.bottomLeft) {
          unpositionedChildStyles['bottom'] = '0';
          unpositionedChildStyles['left'] = '0';
        } else if (alignment == Alignment.bottomCenter) {
          unpositionedChildStyles['bottom'] = '0';
          unpositionedChildStyles['left'] = '50%';
          unpositionedChildStyles['transform'] = 'translateX(-50%)';
        } else if (alignment == Alignment.bottomRight) {
          unpositionedChildStyles['bottom'] = '0';
          unpositionedChildStyles['right'] = '0';
        }
        // For other custom Alignment(x,y) values, you would need to calculate
        // top/left and transform percentages more dynamically.
        // This is a simplification but covers the common alignment cases.

        // Wrap the unpositioned child in a div that applies these styles.
        return div(
          styles: Styles(raw: unpositionedChildStyles),
          [child],
        );
      }).toList(), // Convert iterable to List
    );
  }
}
