import 'package:jaspr/jaspr.dart';

import '../containers/align.dart';

/// Animates the alignment of its child implicitly.
///
/// When the [alignment] property changes, the child will smoothly
/// transition to the new position within the parent.
class AnimatedAlign extends StatefulComponent {
  final Alignment alignment;
  final Duration duration;
  final Component child;
  final Curve curve;
  final double? widthFactor;
  final double? heightFactor;

  const AnimatedAlign({
    required this.alignment,
    required this.duration,
    required this.child,
    this.curve = Curve.linear,
    this.widthFactor, // Not directly supported by CSS for alignment, affects parent sizing
    this.heightFactor, // Affects parent sizing
    super.key,
  });

  @override
  State<AnimatedAlign> createState() => _AnimatedAlignState();
}

class _AnimatedAlignState extends State<AnimatedAlign> {
  // Store the current alignment state for animation
  Alignment? _currentAlignment;

  @override
  void initState() {
    super.initState();
    _currentAlignment = component.alignment;
  }

  @override
  void didUpdateComponent(covariant AnimatedAlign oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.alignment != oldComponent.alignment) {
      _currentAlignment = component.alignment;
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // CSS 'justify-content' and 'align-items' for flexbox can handle alignment.
    // However, for more direct Flutter-like `Alignment` which translates the child,
    // we use absolute positioning and `transform: translate()` with percentages.
    // The percentages are relative to the parent's size MINUS the child's size.
    // e.g., Alignment.topLeft (-1, -1) => translate(0, 0)
    //       Alignment.center (0, 0) => translate(50%, 50%)
    //       Alignment.bottomRight (1, 1) => translate(100%, 100%)

    // Convert Flutter's Alignment to CSS 'left'/'top' percentages and 'transform: translate()'
    // This is the common approach for `Align` and `AnimatedAlign` in web.
    // The `left` and `top` position the child's top-left corner.
    // The `transform: translate()` then shifts the child based on its own size.
    // Together, they center the child according to the desired alignment.

    final double translateXPercentage = (_currentAlignment!.x + 1.0) * 50.0;
    final double translateYPercentage = (_currentAlignment!.y + 1.0) * 50.0;

    final Map<String, String> styles = {
      'position':
          'relative', // The parent div needs to be positioned for absolute child
      'display':
          'flex', // Use flexbox for basic sizing if width/heightFactor not applied
      'justify-content': 'center', // Default center for child
      'align-items': 'center', // Default center for child

      // Optional: if widthFactor/heightFactor are used, mimic by adjusting parent size
      if (component.widthFactor != null)
        'width': '${component.widthFactor! * 100}%',
      if (component.heightFactor != null)
        'height': '${component.heightFactor! * 100}%',
    };

    final Map<String, String> childStyles = {
      'position':
          'absolute', // Child is absolutely positioned within the parent
      'left': '$translateXPercentage%',
      'top': '$translateYPercentage%',
      'transform':
          'translate(-$translateXPercentage%, -$translateYPercentage%)', // Adjust by child's own size
      'transition':
          'left ${component.duration.inMilliseconds}ms ${component.curve.value}, '
              'top ${component.duration.inMilliseconds}ms ${component.curve.value}, '
              'transform ${component.duration.inMilliseconds}ms ${component.curve.value}',
    };

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: styles),
      children: [
        DomComponent(
          tag: 'div', // A wrapper for the child to apply positioning
          styles: Styles(raw: childStyles),
          children: [component.child],
        )
      ],
    );
  }
}

// Example Usage:
// var _alignment = Alignment.topLeft; // State variable in parent
//
// DomComponent(
//   tag: 'button',
//   attributes: {'onclick': (e) {
//     setState(() {
//       _alignment = (_alignment == Alignment.topLeft) ? Alignment.bottomRight : Alignment.topLeft;
//     });
//   }},
//   children: [Text('Toggle Alignment')],
// ),
// Container(
//   width: 300,
//   height: 300,
//   color: Color('lightgray'),
//   child: AnimatedAlign(
//     alignment: _alignment,
//     duration: Duration(milliseconds: 700),
//     curve: Curves.fastOutSlowIn,
//     child: Container(
//       width: 80,
//       height: 80,
//       color: Color('purple'),
//       child: Center(child: Text('Child')),
//     ),
//   ),
// )
