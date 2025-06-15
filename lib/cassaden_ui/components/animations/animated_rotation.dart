import 'package:jaspr/jaspr.dart';

/// Animates the rotation of its child.
///
/// When the [turns] property changes, the child will smoothly
/// rotate over the specified [duration].
class AnimatedRotation extends StatefulComponent {
  final double turns;
  final Duration duration;
  final Component child;
  final Curve curve;

  const AnimatedRotation({
    required this.turns,
    required this.duration,
    required this.child,
    this.curve = Curve.linear,
    super.key,
  });

  @override
  State<AnimatedRotation> createState() => _AnimatedRotationState();
}

class _AnimatedRotationState extends State<AnimatedRotation> {
  double? _currentTurns;

  @override
  void initState() {
    super.initState();
    _currentTurns = component.turns;
  }

  @override
  void didUpdateComponent(covariant AnimatedRotation oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.turns != oldComponent.turns) {
      _currentTurns = component.turns;
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final double angle = _currentTurns! * 360.0; // Full turns to degrees

    final Map<String, String> styles = {
      'display': 'inline-block', // Essential for rotation
      'transform': 'rotate(${angle}deg)',
      'transform-origin': 'center center', // Rotate around the center
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
// var _rotationTurns = 0.0; // State variable in parent
//
// DomComponent(
//   tag: 'button',
//   attributes: {'onclick': (e) {
//     setState(() {
//       _rotationTurns += 0.5; // Rotate by half a turn
//     });
//   }},
//   children: [Text('Rotate')],
// ),
// AnimatedRotation(
//   turns: _rotationTurns,
//   duration: Duration(seconds: 1),
//   curve: Curves.fastOutSlowIn,
//   child: Container(
//     width: 100,
//     height: 100,
//     color: Color('red'),
//     child: Center(child: Text('Spin Me')),
//   ),
// )
