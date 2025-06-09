import 'package:jaspr/jaspr.dart';

import '../containers/align.dart';

/// Animates the scale of its child.
///
/// When the [scale] property changes, the child will smoothly
/// scale over the specified [duration].
class AnimatedScale extends StatefulComponent {
  final double scale;
  final Duration duration;
  final Component child;
  final Curve curve;
  final Alignment alignment; // Transform origin

  const AnimatedScale({
    required this.scale,
    required this.duration,
    required this.child,
    this.curve = Curve.linear,
    this.alignment = Alignment.center, // Default transform origin
    super.key,
  }) : assert(scale >= 0.0, 'Scale must be non-negative.');

  @override
  State<AnimatedScale> createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends State<AnimatedScale> {
  double? _currentScale;

  @override
  void initState() {
    super.initState();
    _currentScale = component.scale;
  }

  @override
  void didUpdateComponent(covariant AnimatedScale oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.scale != oldComponent.scale) {
      _currentScale = component.scale;
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Transform origin in CSS is relative to the element's top-left corner.
    // Flutter's Alignment maps -1.0 to 0%, 0.0 to 50%, 1.0 to 100%.
    final double originX = (component.alignment.x + 1.0) * 50.0;
    final double originY = (component.alignment.y + 1.0) * 50.0;

    final Map<String, String> styles = {
      'display': 'inline-block', // Essential for transforms
      'transform': 'scale(${_currentScale!})',
      'transform-origin': '$originX% $originY%',
      'transition':
          'transform ${component.duration.inMilliseconds}ms ${component.curve.value}',
    };

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: styles),
      children: [component.child],
    );
  }
}

// Example Usage:
// var _scaleValue = 1.0; // State variable in parent
//
// DomComponent(
//   tag: 'button',
//   attributes: {'onclick': (e) {
//     setState(() {
//       _scaleValue = (_scaleValue == 1.0) ? 1.5 : 1.0;
//     });
//   }},
//   children: [Text('Toggle Scale')],
// ),
// AnimatedScale(
//   scale: _scaleValue,
//   duration: Duration(milliseconds: 400),
//   curve: Curves.easeOut,
//   alignment: Alignment.bottomRight, // Scale from bottom-right
//   child: Container(
//     width: 150,
//     height: 100,
//     color: Color('green'),
//     child: Center(child: Text('Grow Me')),
//   ),
// )
