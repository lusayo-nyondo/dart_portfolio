import 'package:jaspr/jaspr.dart';

import 'box_model/box_constraints.dart';

import 'container.dart';
import 'align.dart';

/// A widget that centers its child within itself.
///
/// Mimics Flutter's [Center] widget.
///
/// By default, it expands to take up all available space.

class Center extends StatelessComponent {
  final Component child;
  final double? widthFactor;
  final double? heightFactor;

  const Center({
    super.key,
    required this.child,
    this.widthFactor,
    this.heightFactor,
  });

  @override
  build(BuildContext context) sync* {
    yield Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minWidth: 100.percent,
        minHeight: 100.percent,
      ),
      child: child,
    );
  }
}
