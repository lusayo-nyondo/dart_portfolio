import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/button.dart';
import 'package:dart_portfolio/components/counter.dart';

@client
class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Run code depending on the rendering environment.
    if (kIsWeb) {
      print("Hello client");
      // When using @client components there is no default `main()` function on the client where you would normally
      // run any client-side initialization logic. Instead you can put it here, considering this component is only
      // mounted once at the root of your client-side component tree.
    } else {
      print("Hello server");
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      h1([text('Hello, World!')]),
      p([text('This is my site')]),
      const Counter(),
      const Button(),
    ]);
  }
}
