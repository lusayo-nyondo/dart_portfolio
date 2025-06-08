import 'package:jaspr/jaspr.dart';

enum DividerOrientation { vertical, horizontal }

class Divider extends StatelessComponent {
  final Color? backgroundColor;
  final DividerOrientation orientation;

  const Divider(
      {super.key,
      Color? color,
      this.orientation = DividerOrientation.horizontal})
      : backgroundColor = color;

  @override
  build(BuildContext context) sync* {
    yield hr(
      classes: 'border-0 h-1 my-4 bg-gold',
      styles: Styles(backgroundColor: backgroundColor),
    );
  }
}
