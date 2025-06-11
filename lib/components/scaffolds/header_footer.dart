import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

import 'header.dart';
import 'footer.dart';

class HeaderFooterScaffold extends StatefulComponent {
  const HeaderFooterScaffold({
    required this.child,
    super.key,
  });

  final Component child;

  @override
  State<HeaderFooterScaffold> createState() => _HeaderFooterScaffoldState();
}

class _HeaderFooterScaffoldState extends State<HeaderFooterScaffold> {
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
