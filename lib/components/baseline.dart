import 'package:jaspr/jaspr.dart';

/// A widget that positions its child according to the child's baseline.
///
/// Mimics Flutter's [Baseline] widget.
///
/// **Note on `baselineType`:**
/// Flutter's [Baseline] allows specifying `TextBaseline.alphabetic` or
/// `TextBaseline.ideographic`. Pure CSS does not have a direct, universal
/// way to differentiate or directly control these baseline types for arbitrary
/// child content without JavaScript inspection of font metrics.
///
/// This Jaspr implementation will position the child's top edge at the
/// specified `baseline` offset from the parent's top edge, as this is the most
/// direct CSS equivalent. For true text baseline alignment across multiple
/// elements (e.g., in a row), a flex container with `align-items: baseline`
/// might be a more suitable approach.
class Baseline extends StatelessComponent {
  final Component child;
  final double
      baseline; // The distance from the top of the Baseline box to the child's baseline.

  const Baseline({
    super.key,
    required this.child,
    required this.baseline,
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      classes: 'relative', // Parent for absolute positioning
      // The Baseline container will auto-size its height based on its child's content
      // and the 'top' offset. No explicit height is set here to allow flexibility.
      [
        div(
          classes:
              'absolute left-0', // Position child absolutely within the Baseline container
          styles: Styles(
            margin: Spacing.only(
                top: baseline
                    .px), // Position child's top at the specified baseline offset
          ),
          [child],
        ),
      ],
    );
  }
}
