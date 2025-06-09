import 'package:jaspr/jaspr.dart';

import 'theme/theme.dart'; // Import the new ThemeData

/// An InheritedComponent to efficiently pass ThemeData down the widget tree.
/// This is an internal component used by `JasprApp`.
class _ThemeInheritedWidget extends InheritedComponent {
  const _ThemeInheritedWidget({
    required this.themeData,
    required super.child,
  });

  final ThemeData themeData;

  @override
  bool updateShouldNotify(_ThemeInheritedWidget oldWidget) {
    // Only notify dependents if the ThemeData instance itself changes.
    // Deep comparison of ThemeData properties can be expensive.
    return themeData != oldWidget.themeData;
  }
}

/// The root widget for a Jaspr application that provides theming capabilities.
///
/// Mimics the functionality of Flutter's MaterialApp and CupertinoApp by
/// providing a global Theme to all descendant widgets. It also applies
/// basic global CSS styles (like font family and background) via CSS variables.
class JasprApp extends StatelessComponent {
  /// The theme data for the entire application.
  final ThemeData theme;

  /// The main component/page of the application, typically a Scaffold.
  final Component home;

  const JasprApp({
    super.key,
    required this.theme,
    required this.home,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Inject global CSS variables into the `:root` element.
    // This allows Tailwind and other CSS to reference theme colors and fonts.
    yield DomComponent(
      tag: 'style',
      children: [
        text('''
          :root {
            --primary-color: ${theme.colorScheme.primary.value};
            --primary-variant-color: ${theme.colorScheme.primaryVariant.value};
            --secondary-color: ${theme.colorScheme.secondary.value};
            --secondary-variant-color: ${theme.colorScheme.secondaryVariant.value};
            --surface-color: ${theme.colorScheme.surface.value};
            --background-color: ${theme.colorScheme.background.value};
            --error-color: ${theme.colorScheme.error.value};

            --on-primary-color: ${theme.colorScheme.onPrimary.value};
            --on-secondary-color: ${theme.colorScheme.onSecondary.value};
            --on-surface-color: ${theme.colorScheme.onSurface.value};
            --on-background-color: ${theme.colorScheme.onBackground.value};
            --on-error-color: ${theme.colorScheme.onError.value};

            --text-display-large-size: ${theme.textTheme.displayLarge.fontSize}px;
            --text-display-large-weight: ${theme.textTheme.displayLarge.fontWeight?.value};
            --text-display-large-color: ${theme.textTheme.displayLarge.color?.value};

            /* Add more text theme variables here as needed */
            --font-family: ${theme.fontFamily};
            --default-border-radius: ${theme.defaultBorderRadius}px;
          }

          /* Apply basic global styles to the body */
          body {
            font-family: var(--font-family);
            background-color: var(--background-color);
            color: var(--on-background-color);
            margin: 0;
            padding: 0;
            line-height: 1.5; /* Default line height for body */
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
          }
        '''),
      ],
    );

    // Provide the theme data to the rest of the widget tree via InheritedComponent
    yield _ThemeInheritedWidget(
      themeData: theme,
      child: home,
    );
  }
}
