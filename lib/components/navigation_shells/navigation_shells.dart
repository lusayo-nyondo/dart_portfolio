import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

import 'header.dart';
import 'footer.dart';

class HeaderFooterShell extends StatefulComponent {
  const HeaderFooterShell({
    required this.child,
    super.key,
  });

  final Component child;

  @override
  State<HeaderFooterShell> createState() => _HeaderFooterShellState();
}

class _HeaderFooterShellState extends State<HeaderFooterShell> {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      height: 100.percent,
      width: 100.percent,
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
