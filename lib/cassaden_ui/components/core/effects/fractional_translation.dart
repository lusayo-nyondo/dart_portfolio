import 'package:jaspr/jaspr.dart';

import '../containers/box_model/offset.dart';

/// A component that translates its child by a given offset,
/// where the offset is expressed as a fraction of the child's size.
///
/// Note: This implementation uses CSS `transform: translate()` with percentages.
/// The `dx` and `dy` values are interpreted as fractions of the child's own
/// width and height respectively. For example, Offset(0.5, 0) translates
/// the child by half its width to the right.
class FractionalTranslation extends StatelessComponent {
  final Offset translation;
  final Component child;

  const FractionalTranslation({
    required this.translation,
    required this.child,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // CSS translate with percentages works relative to the element's own size.
    // So dx * 100% and dy * 100% directly map to the fractional translation.
    final String translateX = '${translation.dx * 100}%';
    final String translateY = '${translation.dy * 100}%';

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: {
        'transform': 'translate($translateX, $translateY)',
        'display': 'inline-block', // Often helpful for transforms
      }),
      children: [child],
    );
  }
}

// Example Usage:
// FractionalTranslation(
//   translation: Offset(0.5, 0.0), // Moves child half its width to the right
//   child: Container(
//     width: 100,
//     height: 100,
//     color: Colors.green,
//     child: Text('Moved'),
//   ),
// )

// FractionalTranslation(
//   translation: Offset(0.0, 1.0), // Moves child down by its full height
//   child: Container(
//     width: 50,
//     height: 50,
//     color: Colors.orange,
//   ),
// )
