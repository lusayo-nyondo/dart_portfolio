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
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final double? width;
  final double? height;
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
    Unit? _width = width?.px;
    Unit? _height = height?.px;
    Unit? _minWidth = minWidth?.px;
    Unit? _maxWidth = maxWidth?.px;
    Unit? _minHeight = minHeight?.px;
    Unit? _maxHeight = maxHeight?.px;

    if (constraints != null) {
      _minWidth ??=
          constraints!.minWidth == 0.0 ? null : constraints!.minWidth.px;
      _maxWidth ??= constraints!.maxWidth == double.infinity
          ? null
          : constraints!.maxWidth.px;
      _minHeight ??=
          constraints!.minHeight == 0.0 ? null : constraints!.minHeight.px;
      _maxHeight ??= constraints!.maxHeight == double.infinity
          ? null
          : constraints!.maxHeight.px;
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
              top: 0.px,
              left: 0.px,
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
