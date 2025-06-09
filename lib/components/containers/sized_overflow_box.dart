import 'package:jaspr/jaspr.dart';

import '../box_model/box_constraints.dart'; // Import BoxConstraints

import 'align.dart';
import '../box_model/size.dart';

/// A widget that is a specific size itself, but passes its original constraints
/// through to its child, which may overflow.
///
/// Mimics Flutter's [SizedOverflowBox] widget.
///
/// This is a combination of [SizedBox] (for its own size) and [OverflowBox]
/// (for passing through constraints).
class SizedOverflowBox extends StatelessComponent {
  final Size? size;
  final BoxConstraints? constraints;
  final Component child;
  final Alignment alignment;

  const SizedOverflowBox({
    super.key,
    this.size,
    this.constraints,
    required this.child,
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
    Unit? _width = size?.width.px;
    Unit? _height = size?.height.px;
    Unit? _minWidth;
    Unit? _maxWidth;
    Unit? _minHeight;
    Unit? _maxHeight;

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
              'absolute', // Position the child absolutely within the SizedOverflowBox
          styles: Styles(
            position: Position.absolute(
              top: 0.px,
              left: 0.px,
            ),
            // Align the child within the SizedOverflowBox
            justifyContent: _getJustifyContent(alignment),
            alignItems: _getAlignItems(alignment),
          ),
          [child],
        ),
      ],
    );
  }
}
