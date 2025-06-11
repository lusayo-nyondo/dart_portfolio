import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/components.dart';

import 'pages/home.dart';
import 'pages/about.dart';

// The main component of your application.
//
// By using multi-page routing, this component will only be built on the server during pre-rendering and
// **not** executed on the client. Instead only the nested [Home] and [About] components will be mounted on the client.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield HeaderFooterScaffold(
        headerBuilder: (context, state) => Row(spacing: 20, children: [
              Link(
                  to: '/',
                  child:
                      Button(child: TextComponent('Home'), onPressed: () {})),
              Link(
                  to: '/about',
                  child:
                      Button(child: TextComponent('About'), onPressed: () {})),
            ]),
        routes: [
          Route(
            path: '/',
            builder: (context, state) => Home(),
          ),
          Route(
            path: '/about',
            builder: (context, state) => About(),
          ),
        ]);
  }
}
