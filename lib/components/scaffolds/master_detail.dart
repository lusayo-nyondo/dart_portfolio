import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

import 'footer.dart';

class MasterDetailScaffold extends StatefulComponent {
  const MasterDetailScaffold({
    required this.child,
    super.key,
  });

  final Component child;

  @override
  State<MasterDetailScaffold> createState() => _MasterDetailScaffoldState();
}

class _MasterDetailScaffoldState extends State<MasterDetailScaffold> {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      constraints: BoxConstraints(
        minHeight: 100.vh,
      ),
      child: Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Column(children: [
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
