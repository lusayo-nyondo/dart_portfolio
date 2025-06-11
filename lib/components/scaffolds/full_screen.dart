import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

import 'header.dart';
import 'footer.dart';

class FullScreenScaffold extends StatefulComponent {
  const FullScreenScaffold({
    required this.child,
    super.key,
  });

  final Component child;

  @override
  State<FullScreenScaffold> createState() => _FullScreenScaffoldState();
}

class _FullScreenScaffoldState extends State<FullScreenScaffold> {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      constraints: BoxConstraints(
        minHeight: 100.vh,
      ),
      child: Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Column(children: [
            Header(),
            Expanded(
              child: component.child,
            ),
            Footer(),
          ]),
          routes: [
            Route(
              path: '/',
              builder: (context, state) =>
                  TextComponent('This is the home page.'),
            ),
          ],
        ),
      ]),
    );
  }
}
