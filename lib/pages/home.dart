import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/components.dart';

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
  build(BuildContext context) sync* {
    yield Container(
      margin: Spacing.all(8.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.px),
        color: Colors.aqua,
      ),
      padding: Spacing.all(20.px),
      child: Column.separated(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            h1([text('This is my app!')]),
            Expanded(
              child: MarginComponent(
                margin: Spacing.all(8.px),
                child: Container(
                    color: Colors.aliceBlue,
                    child: TextComponent("Hey there.")),
              ),
            )
          ],
          separatorBuilder: Divider()),
    );
  }
}
