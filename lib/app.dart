import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/components.dart';

import 'routes.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
        height: 100.vh,
        width: 100.vw,
        classList: 'bg-gray-100',
        child: Router(
          routes: getRoutes(context),
        ));
  }
}
