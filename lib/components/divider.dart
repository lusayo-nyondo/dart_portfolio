part of 'components.dart';

enum DividerOrientation { vertical, horizontal }

class Divider extends StatelessComponent
    with HasTailwindClassCollector, BackgroundColorMixin {
  @override
  final Color? backgroundColor;
  final DividerOrientation orientation;

  final TailwindClassCollector _classCollector = const TailwindClassCollector();

  const Divider(
      {super.key,
      Color? color,
      this.orientation = DividerOrientation.horizontal})
      : backgroundColor = color;

  @override
  build(BuildContext context) sync* {
    _classCollector.registerWithGlobalTracker();
    yield hr(
      classes: 'border-0 h-1 my-4 ${_classCollector.className}',
    );
  }
}
