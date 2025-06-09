import 'package:jaspr/jaspr.dart';

/// A component that rotates its child by a fixed number of quarter turns.
class RotatedBox extends StatelessComponent {
  final int quarterTurns;
  final Component child;

  const RotatedBox({
    required this.quarterTurns,
    required this.child,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Calculate the rotation angle in degrees
    final double angle = quarterTurns * 90.0; // 90 degrees per quarter turn

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: {
        'display': 'inline-block', // Essential for rotation to apply correctly
        'transform': 'rotate(${angle}deg)',
        'transform-origin':
            'center center', // Rotate around the center of the element
      }),
      children: [child],
    );
  }
}

// Example Usage:
// RotatedBox(
//   quarterTurns: 1, // Rotates by 90 degrees clockwise
//   child: Container(
//     width: 100,
//     height: 50,
//     color: Colors.blue,
//     child: Text('Rotated'),
//   ),
// )

// RotatedBox(
//   quarterTurns: 2, // Rotates by 180 degrees
//   child: Text('Upside Down'),
// )
