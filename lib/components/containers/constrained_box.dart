import 'package:jaspr/jaspr.dart';

import '../box_model/box_constraints.dart'; // Import the BoxConstraints class

/// A widget that imposes additional constraints on its child.
///
/// Mimics Flutter's [ConstrainedBox] widget.
///
/// This component applies the given constraints to its underlying `div`
/// element using CSS properties like `min-width`, `max-width`, `min-height`, and `max-height`.
class ConstrainedBox extends StatelessComponent {
  final BoxConstraints constraints;
  final Component child;

  const ConstrainedBox({
    super.key,
    required this.constraints,
    required this.child,
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      // Apply CSS min/max properties based on the constraints
      styles: Styles(
        minWidth: constraints.minWidth == 0.0 ? null : constraints.minWidth.px,
        maxWidth: constraints.maxWidth == double.infinity
            ? null
            : constraints.maxWidth.px,
        minHeight:
            constraints.minHeight == 0.0 ? null : constraints.minHeight.px,
        maxHeight: constraints.maxHeight == double.infinity
            ? null
            : constraints.maxHeight.px,
      ),
      [child],
    );
  }
}
