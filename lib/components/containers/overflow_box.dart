// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:jaspr/jaspr.dart';

import 'box_model/box_constraints.dart'; // Import BoxConstraints
import 'align.dart';

/// A widget that imposes different constraints on its child than it itself is constrained to.
///
/// Mimics Flutter's [OverflowBox] widget.
///
/// This is similar to [ConstrainedBox] but the constraints applied to the child
/// do not affect the [OverflowBox]'s own size.
///
/// In CSS, this can be achieved using a combination of `width`, `height`,
/// `min-width`, `max-width`, `min-height`, `max-height`, and `overflow`.
class OverflowBox extends StatelessComponent {
  final BoxConstraints? constraints;
  final Component child;
  final Unit? maxWidth;
  final Unit? maxHeight;
  final Unit? minWidth;
  final Unit? minHeight;
  final Unit? width;
  final Unit? height;
  final Alignment alignment;

  const OverflowBox({
    super.key,
    this.constraints,
    required this.child,
    this.maxWidth,
    this.maxHeight,
    this.minWidth,
    this.minHeight,
    this.width,
    this.height,
    this.alignment = Alignment.topLeft, // Default to top-left (like Flutter)
  });

  // Helper to map Alignment to Jaspr's JustifyContent and AlignItems
  JustifyContent _getJustifyContent(Alignment alignment) {
    if (alignment.x < 0) return JustifyContent.start;
    if (alignment.x > 0) return JustifyContent.end;
    return JustifyContent.center;
  }

  AlignItems _getAlignItems(Alignment alignment) {
    if (alignment.y < 0) return AlignItems.start;
    if (alignment.y > 0) return AlignItems.end;
    return AlignItems.center;
  }

  @override
  build(BuildContext context) sync* {
    // Collect all style properties
    Unit? _width = width;
    Unit? _height = height;
    Unit? _minWidth = minWidth;
    Unit? _maxWidth = maxWidth;
    Unit? _minHeight = minHeight;
    Unit? _maxHeight = maxHeight;

    if (constraints != null) {
      _minWidth ??= constraints!.minWidth == 0.0 ? null : constraints!.minWidth;
      _maxWidth ??=
          constraints!.maxWidth == Unit.auto ? null : constraints!.maxWidth;
      _minHeight ??=
          constraints!.minHeight == 0.0 ? null : constraints!.minHeight;
      _maxHeight ??=
          constraints!.maxHeight == Unit.auto ? null : constraints!.maxHeight;
    }

    yield div(
      classes: 'relative', // For absolute positioning of the child
      styles: Styles(
        width: _width,
        height: _height,
        minWidth: _minWidth,
        maxWidth: _maxWidth,
        minHeight: _minHeight,
        maxHeight: _maxHeight,
      ),
      [
        div(
          classes:
              'absolute', // Position the child absolutely within the OverflowBox
          styles: Styles(
            position: Position.absolute(
              top: Unit.zero,
              left: Unit.zero,
            ),
            // Align the child within the OverflowBox
            justifyContent: _getJustifyContent(alignment),
            alignItems: _getAlignItems(alignment),
          ),
          [child],
        ),
      ],
    );
  }
}
