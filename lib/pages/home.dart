import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/cassaden_ui/components/components.dart';

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
  build(BuildContext context) sync* {
    yield Container(
      alignment: Alignment.center,
      height: 100.percent,
      width: 100.percent,
      padding: Padding.all(16.px),
      margin: Margin.symmetric(vertical: 4.px),
      classList: 'bg-green-700 text-white rounded-lg',
      child: TextComponent("Hey There. This is Lusayo Nyondo."),
    );
  }
}
