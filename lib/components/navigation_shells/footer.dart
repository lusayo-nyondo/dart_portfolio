import 'package:jaspr/jaspr.dart';

import '../components.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      height: 120.px,
      child: footer(
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
            [text('© 2023 Sayo. All rights reserved.')],
          ),
        ],
      ),
    );
  }
}
