import 'package:jaspr/jaspr.dart';

/// Animates the opacity of its child implicitly.
///
/// When the [opacity] property changes, the child's opacity will
/// transition smoothly over the specified [duration].
class AnimatedOpacity extends StatefulComponent {
  final double opacity;
  final Duration duration;
  final Component child;
  final Curve curve; // Jaspr's equivalent of Curve (e.g., Curves.linear)

  const AnimatedOpacity({
    required this.opacity,
    required this.duration,
    required this.child,
    this.curve = Curves.linear, // Default curve
    super.key,
  });

  @override
  State<AnimatedOpacity> createState() => _AnimatedOpacityState();
}

class _AnimatedOpacityState extends State<AnimatedOpacity> {
  // Use a nullable double to allow initial state without transition
  double? _currentOpacity;

  @override
  void initState() {
    super.initState();
    // Initialize opacity without transition on first build
    _currentOpacity = component.opacity;
  }

  @override
  void didUpdateComponent(covariant AnimatedOpacity oldComponent) {
    super.didUpdateComponent(oldComponent);
    // If the opacity changes, trigger a re-render with the new opacity
    if (component.opacity != oldComponent.opacity) {
      _currentOpacity = component.opacity; // Update the value for next render
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final Map<String, String> styles = {
      'opacity': _currentOpacity.toString(),
      'transition':
          'opacity ${component.duration.inMilliseconds}ms ${component.curve.toCssTimingFunction()}',
    };

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: styles),
      children: [component.child],
    );
  }
}

// Dummy Curve and Curves implementations for web mapping
abstract class Curve {
  const Curve();
  String toCssTimingFunction();
}

class _LinearCurve extends Curve {
  const _LinearCurve();
  @override
  String toCssTimingFunction() => 'linear';
}

class _EaseInCurve extends Curve {
  const _EaseInCurve();
  @override
  String toCssTimingFunction() => 'ease-in';
}

class _EaseOutCurve extends Curve {
  const _EaseOutCurve();
  @override
  String toCssTimingFunction() => 'ease-out';
}

class _EaseInOutCurve extends Curve {
  const _EaseInOutCurve();
  @override
  String toCssTimingFunction() => 'ease-in-out';
}

class _CubicBezierCurve extends Curve {
  final double x1, y1, x2, y2;
  const _CubicBezierCurve(this.x1, this.y1, this.x2, this.y2);
  @override
  String toCssTimingFunction() => 'cubic-bezier($x1, $y1, $x2, $y2)';
}

class Curves {
  static const Curve linear = _LinearCurve();
  static const Curve easeIn = _EaseInCurve();
  static const Curve easeOut = _EaseOutCurve();
  static const Curve easeInOut = _EaseInOutCurve();

  // Corresponding to Flutter's fastLinearToSlowEaseIn etc. if needed
  static const Curve fastOutSlowIn = _CubicBezierCurve(0.4, 0.0, 0.2, 1.0);
  static const Curve decelerate = _CubicBezierCurve(0.0, 0.0, 0.2, 1.0);
  static const Curve bounceIn =
      _CubicBezierCurve(0.04, 0.62, 0.16, 1.0); // Approximation
  // Add more as needed based on Flutter's Curves class
}

// Example Usage:
// var _show = true; // State variable in a parent StatefulComponent
//
// DomComponent(
//   tag: 'button',
//   attributes: {'onclick': (e) => setState(() => _show = !_show)},
//   children: [Text('Toggle Opacity')],
// ),
// AnimatedOpacity(
//   opacity: _show ? 1.0 : 0.0,
//   duration: Duration(milliseconds: 500),
//   curve: Curves.easeIn,
//   child: DomComponent(
//     tag: 'div',
//     styles: Styles.raw({
//       'width': '100px',
//       'height': '100px',
//       'background-color': 'blue',
//       'margin-top': '20px',
//     }),
//   ),
// )
