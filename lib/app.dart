import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'cassaden_ui/components/components.dart';

import 'routes.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      height: 100.vh,
      width: 100.vw,
      classList: 'bg-gray-100',
      child: Container(
          classList: 'p-2 max-w-screen-lg mx-auto',
          child: Router(routes: getRoutes(context))),
    );
  }
}
