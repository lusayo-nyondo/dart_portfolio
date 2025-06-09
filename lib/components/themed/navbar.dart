import 'package:jaspr/jaspr.dart';

import '../components.dart';

class Navbar extends StatelessComponent {
  const Navbar({super.key});

  @override
  build(BuildContext context) sync* {
    yield Surface(
      child: PaddingComponent(
          padding: Padding.symmetric(vertical: 16.px),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16.px)),
            ),
            ElevatedButton(child: Text('Click Me!'), onPressed: () {}),
          ])),
    );
  }
}
