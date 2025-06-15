import 'package:jaspr/server.dart';

import 'package:dart_portfolio/app.dart';

import 'package:dart_portfolio/cassaden_ui/cassaden_ui.dart';

import 'jaspr_options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  runApp(
    Document(
      title: 'dart_portfolio',
      head: [
        link(href: 'styles.css', rel: 'stylesheet'),
      ],
      body: JasprApp(
          theme: ThemeData.light(), darkTheme: ThemeData.dark(), home: App()),
    ),
  );
}
