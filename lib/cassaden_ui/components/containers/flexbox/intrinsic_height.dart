import 'package:jaspr/jaspr.dart';

/// A widget that sizes its height to the intrinsic height of its child.
///
/// Mimics Flutter's [IntrinsicHeight] widget.
///
/// In web CSS, achieving a true "intrinsic height" that matches Flutter's
/// behavior (e.g., a row taking the height of its tallest child) is often
/// a natural outcome of Flexbox layout.
///
/// This component simply uses `display: flex` with `flex-direction: column`
/// to ensure the container's height is determined by its children's height.
/// If you place children in a `Row` *inside* this, the `Row` will ensure
/// all children align their baselines and the `Row`'s height is the max.
///
/// **Note:** Pure CSS has limitations in how it determines "intrinsic" sizes
/// for complex nested content compared to Flutter's layout engine.
/// This implementation aims for the most common and direct CSS equivalent.
class IntrinsicHeight extends StatelessComponent {
  final Component child;

  const IntrinsicHeight({
    super.key,
    required this.child,
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      classes:
          'flex flex-col', // Use flexbox with column direction to make container size to children's height
      styles: Styles(
          // The container will size its height based on the cumulative height of its children.
          // For a single child, it will simply take the child's height.
          // If the child is a Row, the Row's height will be determined by its tallest member.
          ),
      [child],
    );
  }
}
