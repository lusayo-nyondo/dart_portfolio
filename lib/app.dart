import 'package:jaspr/jaspr.dart';
import 'components/components.dart';

// The main component of your application.
//
// By using multi-page routing, this component will only be built on the server during pre-rendering and
// **not** executed on the client. Instead only the nested [Home] and [About] components will be mounted on the client.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield HeaderFooterScaffold(
      child: Container(
        child: TextComponent('Hey there!'),
      ),
    );
  }
}
