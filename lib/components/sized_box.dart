import 'package:jaspr/jaspr.dart';

class SizedBox extends StatelessComponent {
  const SizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });
  final double? width;
  final double? height;
  final Component? child;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(attributes: {
      'style': [
        if (width != null) 'width: ${width!}px;',
        if (height != null) 'height: ${height!}px;',
      ].join(' ')
    }, child != null ? [child!] : []);
  }
}
