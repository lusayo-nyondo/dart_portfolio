// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:dart_portfolio/components/header.dart' as prefix0;
import 'package:dart_portfolio/pages/about.dart' as prefix1;
import 'package:dart_portfolio/pages/home.dart' as prefix2;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
JasprOptions get defaultJasprOptions => JasprOptions(
  clients: {
    prefix1.About: ClientTarget<prefix1.About>('pages/about'),

    prefix2.Home: ClientTarget<prefix2.Home>('pages/home'),
  },
  styles: () => [...prefix0.Header.styles, ...prefix1.About.styles],
);
