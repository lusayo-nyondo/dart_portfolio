import 'package:jaspr/server.dart';

import 'package:dart_portfolio/app.dart';

import 'package:dart_portfolio/components/components.dart';

import 'jaspr_options.dart';

/// This static function is called by the `build_runner` custom builder.
/// Its purpose is to ensure that all relevant component constructors (which
/// register Tailwind classes via their mixins) are "executed" during the build
/// process, allowing the `GlobalTailwindTracker` to collect them.
///
/// This code runs ONLY during the build process, not at runtime.
void triggerTailwindCollection() {
  print('main.dart: Triggering Tailwind class collection...');
  Divider(
    color: Colors.gold,
  );
  print('main.dart: Tailwind class collection triggered.');
}

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
      body: App(),
    ),
  );
}
