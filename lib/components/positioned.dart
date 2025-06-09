// lib/components/layout/positioned.dart

import 'package:jaspr/jaspr.dart';

/// A widget that controls the position of its child within a [Stack].
///
/// [Positioned] widgets are typically used as children of a [Stack] widget.
/// They allow you to place their child at a specific distance from the
/// edges of the stack, or to give the child a specific width/height.
///
/// It translates to a `div` with `position: absolute`.
class Positioned extends StatelessComponent {
  /// The distance from the left edge of the [Stack].
  final double? left;

  /// The distance from the top edge of the [Stack].
  final double? top;

  /// The distance from the right edge of the [Stack].
  final double? right;

  /// The distance from the bottom edge of the [Stack].
  final double? bottom;

  /// The width of the child.
  final double? width;

  /// The height of the child.
  final double? height;

  /// The child component to position.
  final Component child;

  const Positioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required this.child,
  })  : assert(
          (width == null || (left == null || right == null)),
          'Do not provide both a width and left/right for a Positioned widget.',
        ),
        assert(
          (height == null || (top == null || bottom == null)),
          'Do not provide both a height and top/bottom for a Positioned widget.',
        );

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final Map<String, String> rawStyles = {
      'position': 'absolute',
    };

    // Note: In CSS, if 'left' and 'right' are both set and 'width' is null,
    // the element will expand to fill the space. Similar for 'top'/'bottom'/'height'.
    // This mimics Flutter's behavior when two opposite constraints are set.
    if (left != null) rawStyles['left'] = '${left}px';
    if (top != null) rawStyles['top'] = '${top}px';
    if (right != null) rawStyles['right'] = '${right}px';
    if (bottom != null) rawStyles['bottom'] = '${bottom}px';
    if (width != null) rawStyles['width'] = '${width}px';
    if (height != null) rawStyles['height'] = '${height}px';

    yield div(
      styles: Styles(raw: rawStyles),
      [child],
    );
  }
}
