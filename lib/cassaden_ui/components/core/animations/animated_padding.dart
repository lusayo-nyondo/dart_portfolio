import 'package:jaspr/jaspr.dart';

/// Animates the padding of its child implicitly.
///
/// When the [padding] property changes, the child will smoothly
/// transition to the new padding values.
class AnimatedPadding extends StatefulComponent {
  final Spacing padding;
  final Duration duration;
  final Component child;
  final Curve curve;

  const AnimatedPadding({
    required this.padding,
    required this.duration,
    required this.child,
    this.curve = Curve.linear,
    super.key,
  });

  @override
  State<AnimatedPadding> createState() => _AnimatedPaddingState();
}

class _AnimatedPaddingState extends State<AnimatedPadding> {
  Spacing? _currentPadding;

  @override
  void initState() {
    super.initState();
    _currentPadding = component.padding;
  }

  @override
  void didUpdateComponent(covariant AnimatedPadding oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.padding != oldComponent.padding) {
      _currentPadding = component.padding;
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final Map<String, String> styles = {
      'padding-left': '${_currentPadding!.left}px',
      'padding-top': '${_currentPadding!.top}px',
      'padding-right': '${_currentPadding!.right}px',
      'padding-bottom': '${_currentPadding!.bottom}px',
      'transition':
          'padding ${component.duration.inMilliseconds}ms ${component.curve.value}',
    };

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: styles),
      children: [component.child],
    );
  }
}

// Example Usage:
// var _currentPadding = Spacing.only(left: 10, top: 10); // State variable
//
// DomComponent(
//   tag: 'button',
//   attributes: {'onclick': (e) {
//     setState(() {
//       _currentPadding = (_currentPadding.left == 10) ? Spacing.only(left: 50, top: 30, right: 20) : Spacing.only(left: 10, top: 10);
//     });
//   }},
//   children: [Text('Toggle Padding')],
// ),
// Container(
//   width: 200,
//   height: 200,
//   color: Color('lightblue'),
//   child: AnimatedPadding(
//     padding: _currentPadding,
//     duration: Duration(milliseconds: 600),
//     curve: Curves.easeOut,
//     child: Container(
//       color: Color('darkblue'),
//       child: Center(child: Text('Padded Content', style: Styles.text(color: Color('white')))),
//     ),
//   ),
// )
