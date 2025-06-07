import 'package:jaspr/jaspr.dart';

class Button extends StatelessComponent {
  const Button();

  @override
  build(BuildContext context) sync* {
    yield div(attributes: {
      'x-data': '{ open: false }'
    }, [
      button(attributes: {'@click': 'open = true'}, [text('Expand')]),
      span([text('Content...')])
    ]);
  }
}
