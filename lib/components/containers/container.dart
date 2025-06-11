// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:jaspr/jaspr.dart';
import 'box_model/box_constraints.dart'; // Import BoxConstraints
import 'box_model/box_decoration.dart'; // Import BoxDecoration and its helpers
import 'align.dart'; // Import Alignment for alignment property

/// A convenience widget that combines common painting, positioning, and sizing widgets.
///
/// Mimics Flutter's [Container] widget.
///
/// **Note on Properties:**
/// Not all Flutter [Container] properties are fully replicated due to
/// differences in web CSS capabilities and complexity.
///
/// - **`decoration`**: This component directly uses the `BoxDecoration` properties
///   (color, border, borderRadius, boxShadow). More complex decorations like
///   gradients, background images, or arbitrary shapes would require custom CSS
///   (e.g., via `Styles.raw()`).
/// - **`foregroundDecoration`**: Not directly supported due to CSS complexity.
/// - **`transform`**: Flutter uses `Matrix4`. This component would need to accept
///   a raw CSS transform string (e.g., `'rotate(45deg) scale(1.2)'`) if implemented.
class Container extends StatelessComponent {
  final Component? child;
  final Alignment? alignment;
  final Spacing? padding;
  final Color? color; // Background color
  final BoxDecoration? decoration; // Overrides 'color' if both are present
  final Unit? width;
  final Unit? height;
  final BoxConstraints? constraints;
  final Spacing? margin;
  // final String? transform; // For CSS transform string like 'rotate(45deg)'

  const Container({
    super.key,
    this.child,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    // this.transform,
  });

  @override
  build(BuildContext context) sync* {
    final List<String> classes = [];

    // --- Prepare CSS properties for the Styles constructor ---
    Unit? _width = width;
    Unit? _height = height;
    Unit? _minWidth;
    Unit? _maxWidth;
    Unit? _minHeight;
    Unit? _maxHeight;
    Color? _backgroundColor;
    Border? _border;
    BorderRadius? _borderRadius;
    BoxShadow? _boxShadow;
    Spacing? _padding = padding;
    Spacing? _margin = margin;
    JustifyContent? _justifyContent;
    AlignItems? _alignItems;
    // String? _transform = transform; // if transform was implemented

    // 1. Handle alignment (if specified, use flexbox)
    if (alignment != null) {
      classes.add('flex'); // Make the container a flex container
      if (alignment!.x < 0) _justifyContent = JustifyContent.start;
      if (alignment!.x > 0) _justifyContent = JustifyContent.end;
      if (alignment!.x == 0) _justifyContent = JustifyContent.center;

      if (alignment!.y < 0) _alignItems = AlignItems.start;
      if (alignment!.y > 0) _alignItems = AlignItems.end;
      if (alignment!.y == 0) _alignItems = AlignItems.center;
    }

    // 2. Handle color or decoration (decoration takes precedence)
    if (decoration != null) {
      if (decoration!.color != null) {
        _backgroundColor = decoration!.color!;
      }
      if (decoration!.border != null &&
          decoration!.border!.style != BorderStyle.none) {
        _border = Border(
          color: decoration!.border!.color,
          width: decoration!.border!.width,
          style: decoration!.border!.style == BorderStyle.solid
              ? BorderStyle.solid
              : BorderStyle.none,
        );
      }
      _borderRadius = decoration?.borderRadius;

      if (decoration!.boxShadow != null) {
        _boxShadow = decoration!.boxShadow!;
      }
    } else if (color != null) {
      // If no decoration, use the direct color
      _backgroundColor = color!;
    }

    // 3. Handle width and height
    _width = width;
    _height = height;

    // 4. Handle constraints (min/max width/height)
    if (constraints != null) {
      if (constraints!.minWidth != Unit.zero) {
        _minWidth = constraints!.minWidth;
        _width ??= _minWidth;
      }

      if (constraints!.maxWidth != Unit.auto) {
        _maxWidth = constraints!.maxWidth;
      }
      if (constraints!.minHeight != Unit.zero) {
        _minHeight = constraints!.minHeight;
        _height ??= _minHeight;
      }
      if (constraints!.maxHeight != Unit.auto) {
        _maxHeight = constraints!.maxHeight;
      }
    }

    // 5. Handle margin
    _margin = margin;

    // 6. Transform (if implemented)
    // if (transform != null) {
    //   _transform = transform;
    // }

    yield div(
      classes: classes.join(' '),
      styles: Styles(
        width: _width,
        height: _height,
        minWidth: _minWidth,
        maxWidth: _maxWidth,
        minHeight: _minHeight,
        maxHeight: _maxHeight,
        backgroundColor: _backgroundColor,
        border: _border,
        radius: _borderRadius,
        shadow: _boxShadow,
        padding: _padding,
        margin: _margin,
        justifyContent: _justifyContent,
        alignItems: _alignItems,
        // transform: _transform,
      ),
      [if (child != null) child!],
    );
  }
}
