import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../../components.dart';

part 'links.dart';

class Navbar extends StatelessComponent {
  final Component? leading;
  final Component? trailing;
  final List<NavLink> actions;

  const Navbar({super.key, this.leading, this.trailing, required this.actions});

  @override
  build(BuildContext context) sync* {
    yield Container(
      element: 'nav',
      classList:
          'block w-full max-w-screen-lg px-4 py-2 mx-auto bg-white shadow-md rounded-md lg:px-8 lg:py-3 mt-10',
      child: div(
          classes:
              'container flex flex-wrap items-center justify-between mx-auto text-slate-800',
          [
            if (leading != null) leading!,
            div(classes: 'hidden lg:block', [
              ul(
                classes:
                    'flex flex-col gap-2 mt-2 mb-4 lg:mb-0 lg:mt-0 lg:flex-row lg:items-center lg:gap-6',
                actions,
              ),
            ]),
          ]),
    );
  }
}
