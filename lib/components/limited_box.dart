import 'package:jaspr/jaspr.dart';

/// A box that limits its size only when it's unconstrained.
///
/// Mimics Flutter's [LimitedBox] widget.
///
/// **Important Limitations in Pure CSS:**
/// In Flutter's layout model, a widget can be "unconstrained" in a dimension
/// (e.g., given `double.infinity` width). [LimitedBox] only applies its limits
/// in such "unconstrained" scenarios.
///
/// In standard web CSS, an element always receives concrete constraints from its
/// parent. The concept of an "unconstrained" element that might then be limited
/// conditionally isn't directly observable or implementable without JavaScript
/// to inspect parent constraints at runtime.
///
/// Therefore, this Jaspr [LimitedBox] will simply apply `max-width` and `max-height`
/// CSS properties to its underlying `div`. These limits will *always* apply,
/// regardless of whether the parent "constrains" the child more tightly.
/// It cannot replicate Flutter's conditional behavior in pure CSS.
class LimitedBox extends StatelessComponent {
  final Component child;
  final double maxWidth;
  final double maxHeight;

  const LimitedBox({
    super.key,
    required this.child,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      styles: Styles(
        maxWidth: maxWidth == double.infinity ? null : maxWidth.px,
        maxHeight: maxHeight == double.infinity ? null : maxHeight.px,
      ),
      [child],
    );
  }
}
