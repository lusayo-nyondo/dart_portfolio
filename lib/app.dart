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
    yield Container(
      height: 100.vh,
      width: 100.vw,
      child: Container(),
    );
  }
  /*
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      height: 100.vh,
      width: 100.vw,
      child: SidebarScaffold(
          child: Center(child: Text("Hello, World!")),
          sidebarBuilder: (context, routeState, sidebarState) => Container(
                padding: Padding.all(8.px),
                height: 100.percent,
                decoration: BoxDecoration(
                  border: Border.only(
                      right: BorderSide(width: 1.px, color: Colors.black)),
                ),
                child: Column(spacing: 8, children: [
                  SidebarLink(
                      path: '/',
                      child: TextComponent('Home'),
                      isActive: routeState.fullpath == '/'),
                  SidebarLink(
                      path: '/about',
                      child: TextComponent('About'),
                      isActive: routeState.fullpath == '/about'),
                  SidebarLink(
                    path: '/nested',
                    child: TextComponent('Nested Scaffold'),
                    isActive: routeState.fullpath == '/nested',
                  ),
                ]),
              ),
          routes: <RouteBase>[
            Route(path: '/', name: 'home', builder: (context, state) => Home()),
            Route(
                path: '/about',
                name: 'about',
                builder: (context, state) => Center(child: About())),
            Route(
              path: '/nested',
              name: 'nested',
              builder: (context, state) => getNested(context),
            )
          ]),
    );
  }

  Component getNested(BuildContext context) {
    return Container(
        height: 100.vh,
        child: HeaderFooterScaffold(
          headerBuilder: (context, state) {
            print("Header builder gotten state: $state");
            print("Route name: ${state.name}");
            return Container(
              padding: Padding.all(6.px),
              decoration: BoxDecoration(
                boxShadow: BoxShadow(
                    offsetX: 0.px,
                    offsetY: 0.px,
                    blur: 2.px,
                    spread: 0.1.px,
                    color: Color.rgba(0, 0, 0, 0.8)),
              ),
              child: Row(spacing: 20, children: [
                NavLink(
                    path: '/',
                    child: TextComponent('Home'),
                    isActive: state.fullpath == '/'),
                NavLink(
                    path: '/about',
                    child: TextComponent('About'),
                    isActive: state.fullpath == '/about'),
              ]),
            );
          },
          routes: [
            Route(
              path: '/',
              name: 'home',
              builder: (context, state) => Home(),
            ),
            Route(
              path: '/about',
              name: 'about',
              builder: (context, state) => About(),
            ),
            Route(
              path: '/nested',
              name: 'nested',
              builder: (context, state) =>
                  Center(child: TextComponent('Deep nesting')),
            )
          ],
        ));
  }
  */
}
