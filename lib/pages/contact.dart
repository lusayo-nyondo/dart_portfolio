import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/cassaden_ui/components/components.dart';

class Contact extends StatefulComponent {
  const Contact({super.key});

  @override
  State<Contact> createState() => ContactState();
}

class ContactState extends State<Contact> {
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
    yield Center(
      child: TextComponent('Contact page.'),
    );
  }
}
