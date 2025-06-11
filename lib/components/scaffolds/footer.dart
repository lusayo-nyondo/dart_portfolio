import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield footer(
      classes: [
        'flex',
        'flex-col',
        'items-center',
        'justify-center',
        'p-4',
        'bg-gray-800',
        'text-white',
        'h-[120px]',
        'w-full',
      ].join(' '),
      [
        p(
          [text('© 2023 Sayo. All rights reserved.')],
        ),
      ],
    );
  }
}
