// ui_core/themed/surface.dart
import 'package:jaspr/jaspr.dart';

import '../components.dart';

/// Defines the semantic role and default color of a Surface.
/// This maps directly to colors in your ColorScheme.
enum SurfaceType {
  /// The lowest layer, representing the background of the app.
  background,

  /// A general container surface, used for cards, dialogs, menus, etc.
  surface,

  /// A surface prominently displaying the primary brand color.
  primary,

  /// A surface prominently displaying the secondary accent color.
  secondary,

  /// A surface indicating an error state.
  error,
}

/// A foundational component that defines a themed surface in the UI hierarchy.
///
/// It automatically applies background colors and shadows based on its [type]
/// and [elevation], drawing from the inherited [ThemeData].
class Surface extends StatelessComponent {
  final Component? child;

  /// The semantic type of the surface, determining its default color.
  final SurfaceType type;

  /// The logical elevation of this surface, determining its shadow.
  /// Higher elevation means a more pronounced shadow.
  final double elevation;

  /// An explicit color to override the default color derived from [type].
  final Color? color;

  /// The border radius of the surface's corners.
  final BorderRadius? borderRadius;

  /// A border to draw around the surface.
  final Border? border;

  /// Padding to apply inside the surface, around its [child].
  final Spacing? padding;

  /// An explicit list of box shadows to override the default shadow derived from [elevation].
  final List<BoxShadow>? boxShadows;

  const Surface({
    this.child,
    this.type = SurfaceType.surface, // Default to a general surface
    this.elevation = 0.0, // Default no elevation (flat)
    this.color,
    this.borderRadius,
    this.border,
    this.padding,
    this.boxShadows, // Allows overriding default elevation shadows
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Resolve the background color based on type and override
    Color resolvedColor;
    switch (type) {
      case SurfaceType.background:
        resolvedColor = colorScheme.background;
        break;
      case SurfaceType.surface:
        resolvedColor = colorScheme.surface;
        break;
      case SurfaceType.primary:
        resolvedColor = colorScheme.primary;
        break;
      case SurfaceType.secondary:
        resolvedColor = colorScheme.secondary;
        break;
      case SurfaceType.error:
        resolvedColor = colorScheme.error;
        break;
    }
    resolvedColor =
        color ?? resolvedColor; // Explicit color overrides the type-based color

    // 2. Resolve the box shadows based on elevation or explicit override
    List<BoxShadow>? finalBoxShadows = boxShadows;
    if (finalBoxShadows == null && elevation > 0) {
      // Simplified shadow generation for Material-like effect
      // In a full design system, you'd have pre-defined shadow lists per elevation.
      final double blurRadius =
          elevation * 2.5; // Larger blur for higher elevation
      final double spreadRadius = elevation * 0.5; // Slight spread
      final double offsetY = elevation * 1.5; // Offset in Y for perspective

      // Shadow color can also be themed or depend on elevation
      final Color shadowColor =
          Colors.black.withOpacity(0.2 + (elevation * 0.01).clamp(0.0, 0.2));

      finalBoxShadows = [
        BoxShadow(
            color: shadowColor,
            blur: blurRadius.px,
            spread: spreadRadius.px,
            offsetX: 0.px,
            offsetY: offsetY.px),
      ];
    }

    yield DomComponent(
      tag: 'div', // A div is a good generic container for a surface
      styles: Styles(
        backgroundColor: resolvedColor,
        border: border,
        radius: borderRadius,
        padding: padding,
        shadow: finalBoxShadows?[0], // Pass the list of shadows
        // Apply position: relative if you might have positioned children
        // or for z-index stacking.
        position: Position.relative(),
      ),
      children: [
        if (child != null) child!,
      ],
    );
  }
}

// --- Example Usage in your Themed Components ---

// Assuming ui_core/themed/card.dart
/*
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_ui_core/themed/surface.dart'; // Import your Surface component
import 'package:jaspr_ui_core/box_model/box_constraints.dart'; // For BorderRadius

class Card extends StatelessComponent {
  final Component? child;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Spacing? padding;

  const Card({
    this.child,
    this.elevation,
    this.borderRadius,
    this.padding,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Surface(
      type: SurfaceType.surface, // Cards are typically on the 'surface' layer
      elevation: elevation ?? 1.0, // Default card elevation
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(8.0)), // Default card corner radius
      padding: padding ?? Spacing.all(16.0), // Default card padding
      child: child,
    );
  }
}
*/

// Assuming ui_core/themed/dialog.dart
/*
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_ui_core/themed/surface.dart';
import 'package:jaspr_ui_core/box_model/box_constraints.dart';

class Dialog extends StatelessComponent {
  final Component? child;
  final BorderRadius? borderRadius;
  final Spacing? padding;

  const Dialog({
    this.child,
    this.borderRadius,
    this.padding,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Surface(
      type: SurfaceType.surface, // Dialogs also use the surface color
      elevation: 24.0, // Dialogs have significantly higher elevation
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(12.0)),
      padding: padding ?? Spacing.all(24.0),
      child: child,
    );
  }
}
*/

// Assuming ui_core/themed/scaffold.dart
/*
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_ui_core/themed/surface.dart';
import 'package:jaspr_ui_core/flexbox/column.dart'; // Your Column component
import 'package:jaspr_ui_core/flexbox/expanded.dart'; // Your Expanded component
import 'package:jaspr_ui_core/typography/text.dart'; // Your Text component (for placeholder)

class Scaffold extends StatelessComponent {
  final Component? appBar;
  final Component? body;
  // Add other common Scaffold slots here like bottomNavigationBar, drawer, etc.

  const Scaffold({
    this.appBar,
    this.body,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Surface(
      type: SurfaceType.background, // Scaffold's base is the background surface
      elevation: 0.0, // Typically no shadow for the main background
      // You might add padding here if the entire screen needs a border margin
      child: Column(
        children: [
          if (appBar != null) appBar!, // Your AppBar component would go here
          Expanded( // Body takes remaining space
            child: body ?? Text(''), // Body content
          ),
          // Add other slots like BottomNavigationBar here
        ],
      ),
    );
  }
}
*/
