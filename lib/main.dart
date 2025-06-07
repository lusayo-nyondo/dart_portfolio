// The entrypoint for the **server** environment.
//
// The [main] method will only be executed on the server during pre-rendering.
// To run code on the client, use the @client annotation.

// Server-specific jaspr import.
import 'package:jaspr/server.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'jaspr_options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  // Starts the app.
  //
  // [Document] renders the root document structure (<html>, <head> and <body>)
  // with the provided parameters and components.
  runApp(Document(
    title: 'dart_portfolio',
    head: [
      link(href: 'styles.css', rel: 'stylesheet'),
    ],
    body: div(
      [
        h1(
          [
            text('Welcome to my Dart Portfolio!'),
          ],
        ),
        script(
          [],
          defer: true,
          src: '//unpkg.com/alpinejs',
        ),
      ],
      classes:
          'container bg-red-100 text-gray-900 rounded-lg shadow-lg mx-auto my-8 p-6',
    ),
  ));
}
