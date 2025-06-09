import 'package:jaspr/jaspr.dart';

/// Animates the position of a child that is inside a positioned parent.
///
/// When the [left], [top], [right], or [bottom] properties change,
/// the child will smoothly transition to the new position.
class AnimatedPositioned extends StatefulComponent {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  final Duration duration;
  final Component child;
  final Curve curve;

  const AnimatedPositioned({
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required this.duration,
    required this.child,
    this.curve = Curve.linear,
    super.key,
  });

  @override
  State<AnimatedPositioned> createState() => _AnimatedPositionedState();
}

class _AnimatedPositionedState extends State<AnimatedPositioned> {
  // Store current values for animation
  double? _currentLeft;
  double? _currentTop;
  double? _currentRight;
  double? _currentBottom;
  double? _currentWidth;
  double? _currentHeight;

  @override
  void initState() {
    super.initState();
    _currentLeft = component.left;
    _currentTop = component.top;
    _currentRight = component.right;
    _currentBottom = component.bottom;
    _currentWidth = component.width;
    _currentHeight = component.height;
  }

  @override
  void didUpdateComponent(covariant AnimatedPositioned oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.left != oldComponent.left) _currentLeft = component.left;
    if (component.top != oldComponent.top) _currentTop = component.top;
    if (component.right != oldComponent.right) _currentRight = component.right;
    if (component.bottom != oldComponent.bottom)
      _currentBottom = component.bottom;
    if (component.width != oldComponent.width) _currentWidth = component.width;
    if (component.height != oldComponent.height)
      _currentHeight = component.height;
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final Map<String, String> styles = {
      'position': 'absolute', // Essential for positioned children
      if (_currentLeft != null) 'left': '${_currentLeft}px',
      if (_currentTop != null) 'top': '${_currentTop}px',
      if (_currentRight != null) 'right': '${_currentRight}px',
      if (_currentBottom != null) 'bottom': '${_currentBottom}px',
      if (_currentWidth != null) 'width': '${_currentWidth}px',
      if (_currentHeight != null) 'height': '${_currentHeight}px',
      'transition': 'left ${component.duration.inMilliseconds}ms ${component.curve.value}, '
          'top ${component.duration.inMilliseconds}ms ${component.curve.value}, '
          'right ${component.duration.inMilliseconds}ms ${component.curve.value}, '
          'bottom ${component.duration.inMilliseconds}ms ${component.curve.value}, '
          'width ${component.duration.inMilliseconds}ms ${component.curve.value}, '
          'height ${component.duration.inMilliseconds}ms ${component.curve.value}',
    };

    yield DomComponent(
      tag: 'div', // Child wrapper for absolute positioning
      styles: Styles(raw: styles),
      children: [component.child],
    );
  }
}

// Example Usage (requires a positioned parent like a Container with position: relative)
// var _currentPosition = 0.0; // State variable in parent
//
// DomComponent(
//   tag: 'button',
//   attributes: {'onclick': (e) {
//     setState(() {
//       _currentPosition = (_currentPosition == 0.0) ? 100.0 : 0.0;
//     });
//   }},
//   children: [Text('Toggle Position')],
// ),
// Container(
//   width: 300,
//   height: 300,
//   color: Color('lightgreen'),
//   styles: Styles(raw: {'position': 'relative'}), // Parent must be positioned
//   child: AnimatedPositioned(
//     left: _currentPosition,
//     top: _currentPosition,
//     duration: Duration(milliseconds: 700),
//     curve: Curves.elasticOut, // Example of another curve
//     child: Container(
//       width: 50,
//       height: 50,
//       color: Color('darkgreen'),
//       child: Center(child: Text('Box', style: Styles.text(color: Color('white')))),
//     ),
//   ),
// )
