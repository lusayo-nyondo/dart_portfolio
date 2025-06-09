import 'package:jaspr/jaspr.dart';

/// A widget that adds empty space around another widget.
///
/// Mimics Flutter's [Padding] widget.
///
/// This component directly uses Jaspr's `Spacing` object for padding.
class Padding extends StatelessComponent {
  final Component child;
  final Spacing padding;

  const Padding({
    super.key,
    required this.child,
    required this.padding,
  });

  const Padding.all(Spacing padding)
      : this(child: const Text(''), padding: padding);

  Padding.only({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) : this(
            child: const Text(''),
            padding: Spacing.only(
                left: left?.px,
                top: top?.px,
                right: right?.px,
                bottom: bottom?.px));

  Padding.symmetric({double horizontal = 0.0, double vertical = 0.0})
      : this(
            child: const Text(''),
            padding: Spacing.symmetric(
                horizontal: horizontal.px, vertical: vertical.px));

  @override
  build(BuildContext context) sync* {
    yield div(
      styles: Styles(
        padding: padding,
      ),
      [child],
    );
  }
}
