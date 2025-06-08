import 'package:jaspr/server.dart';

import 'package:dart_portfolio/app.dart';

import 'jaspr_options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  runApp(Document(
    title: 'dart_portfolio',
    head: [
      link(href: 'styles.css', rel: 'stylesheet'),
    ],
    body: div(
      [
        App(),
        script(
          [],
          defer: true,
          src: '//unpkg.com/alpinejs',
        ),
      ],
    ),
  ));
}
