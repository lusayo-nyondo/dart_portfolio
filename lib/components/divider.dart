part of 'components.dart';

class Divider extends StatelessComponent
    with BaseColorPropertyMixin, ColorMixin {
  @override
  final Color? color;

  const Divider({super.key, this.color});

  @override
  build(BuildContext context) sync* {
    yield hr(
      classes: getTailwindClassName(),
    );
  }
}
