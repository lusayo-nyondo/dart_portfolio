import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/components.dart';

class Resume extends StatefulComponent {
  const Resume({super.key});

  @override
  State<Resume> createState() => ResumeState();
}

class ResumeState extends State<Resume> {
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
      child: TextComponent('Resume page.'),
    );
  }
}
