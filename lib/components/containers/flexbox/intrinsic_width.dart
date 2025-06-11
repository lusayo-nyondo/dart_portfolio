import 'package:jaspr/jaspr.dart';

/// A widget that sizes its width to the intrinsic width of its child.
///
/// Mimics Flutter's [IntrinsicWidth] widget.
///
/// In web CSS, achieving a true "intrinsic width" that matches Flutter's
/// behavior (e.g., a column taking the width of its widest child) is often
/// a natural outcome of Flexbox layout combined with `max-content` or `inline-flex`.
///
/// This component uses `display: flex` with `flex-direction: column` to ensure
/// the container's width is determined by its widest child.
///
/// **Note:** Similar to [IntrinsicHeight], pure CSS has limitations in how it
/// determines "intrinsic" sizes for complex nested content compared to Flutter's
/// layout engine. This implementation aims for the most common and direct CSS equivalent.
class IntrinsicWidth extends StatelessComponent {
  final Component child;

  const IntrinsicWidth({
    super.key,
    required this.child,
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      classes: 'flex flex-col', // Use flexbox with column direction
      styles: Styles(
          // This will make the div's width determined by the widest flex item (child).
          // flex-shrink: 0 on children (default for flex items with content) also helps.
          // Another option is `width: max_content` but browser support varies.
          // `inline-flex` also forces shrink-wrapping horizontally.
          // Let's go with the flex-col which makes parent width follow widest child.
          ),
      [child],
    );
  }
}
