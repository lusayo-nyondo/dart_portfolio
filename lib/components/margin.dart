import 'package:jaspr/jaspr.dart';

/// A widget that adds empty space around another widget.
/// This component directly uses Jaspr's `Spacing` object for margin.
class MarginComponent extends StatelessComponent {
  final Component child;
  final Spacing margin;

  const MarginComponent({
    super.key,
    required this.child,
    required this.margin,
  });

  const MarginComponent.all(Spacing margin)
      : this(child: const Text(''), margin: margin);

  MarginComponent.only({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) : this(
            child: const Text(''),
            margin: Spacing.only(
                left: left?.px,
                top: top?.px,
                right: right?.px,
                bottom: bottom?.px));

  MarginComponent.symmetric({double horizontal = 0.0, double vertical = 0.0})
      : this(
            child: const Text(''),
            margin: Spacing.symmetric(
                horizontal: horizontal.px, vertical: vertical.px));

  @override
  build(BuildContext context) sync* {
    yield div(
      styles: Styles(
        margin: margin,
      ),
      [child],
    );
  }
}
