import 'package:jaspr/jaspr.dart';

import '../components.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      height: 60.px,
      child: header(
        classes: [
          'flex',
          'flex-col',
          'items-center',
          'justify-center',
          'p-4',
          'bg-gray-800',
          'text-white',
        ].join(' '),
        [
          p(
            [text("Here's my app logo.")],
          ),
        ],
      ),
    );
  }
}
