import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'package:universal_web/web.dart';
import 'package:universal_web/js_interop.dart';

import 'containers/positioned/stack.dart';
import 'theme/theme.dart'; // Import the new ThemeData
import 'themed/text/text.dart';

// An InheritedComponent to efficiently pass ThemeData down the component tree.
/// This is an internal component used by `JasprApp`.
class _ThemeInheritedComponent extends InheritedComponent {
  const _ThemeInheritedComponent({
    required this.themeData,
    required super.child,
  });

  final ThemeData themeData;

  @override
  bool updateShouldNotify(_ThemeInheritedComponent oldComponent) {
    // Only notify dependents if the ThemeData instance itself changes.
    return themeData != oldComponent.themeData;
  }
}

/// The root component for a Jaspr application that provides theming and routing capabilities.
///
/// This component aims to mimic the core functionalities of Flutter's `MaterialApp`.
class JasprApp extends StatefulComponent {
  /// The title of the application, displayed in the browser tab.
  final String title;

  /// The default light theme data for the application.
  final ThemeData theme;

  /// The dark theme data for the application.
  final ThemeData darkTheme;

  /// The preferred theme mode (light, dark, or system).
  /// Defaults to [ThemeMode.system].
  final ThemeMode themeMode;

  /// The main component/page of the application when no routes are specified.
  /// If `routes` are provided, this component is used as the default for the '/' route.
  final Component? home;

  /// A list of routes to be used by the [Router].
  ///
  /// This corresponds to Flutter's `MaterialApp.routes` but uses `jaspr_router`'s
  /// [RouteBase] definitions.
  final Iterable<RouteBase> routes;

  /// The initial route to display. If not specified, the router will
  /// typically use the current browser's path.
  ///
  /// This maps to `jaspr_router`'s `initialLocation`.
  final String? initialRoute;

  /// Called to provide a custom builder for the entire application's content.
  ///
  /// This can be used to inject global components or providers that should
  /// wrap the theme and router.
  final Component Function(BuildContext context, Component child)? builder;

  /// Whether to show a "DEBUG" banner in checked mode.
  final bool debugShowCheckedModeBanner;

  const JasprApp({
    super.key,
    this.title = '',
    required this.theme,
    required this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.home,
    this.routes = const [],
    this.initialRoute,
    this.builder,
    this.debugShowCheckedModeBanner = true,
  });

  @override
  State<JasprApp> createState() => _JasprAppState();

  /// Helper to get the theme data from context.
  static ThemeData of(BuildContext context) {
    final _ThemeInheritedComponent? inheritedTheme = context
        .dependOnInheritedComponentOfExactType<_ThemeInheritedComponent>();
    assert(inheritedTheme != null,
        'No ThemeData found in context. Wrap your app in a JasprApp.');
    return inheritedTheme!.themeData;
  }
}

class _JasprAppState extends State<JasprApp> {
  ThemeData? _activeTheme;

  late MediaQueryList _mediaQueryList;
  late JSFunction _jsListenerFunction;

  @override
  void initState() {
    super.initState();
    _updateActiveTheme();

    // Set initial browser tab title
    if (kIsWeb) {
      document.title = component.title;
      // Listen for system theme changes if themeMode is system
      _mediaQueryList = window.matchMedia('(prefers-color-scheme: dark)');

      // Define your Dart function/callback.
      // It must take a web.Event as its argument.
      void dartListener(Event event) {
        // Access 'matches' directly from _mediaQueryList (which is a web.MediaQueryList)
        print(
            'Preferred color scheme changed: ${_mediaQueryList.matches ? 'dark' : 'light'}');

        if (component.themeMode == ThemeMode.system) {
          _updateActiveTheme();
        }
      }

      // Convert your Dart function to a JavaScript function (JSFunction)
      // using the .toJS extension method from 'dart:js_interop'.
      _jsListenerFunction = dartListener.toJS;

      // Add the listener. The addListener method on web.MediaQueryList expects
      // a web.EventListener, which is a JSFunction.
      // We explicitly cast for clarity, but it's often inferred correctly.
      _mediaQueryList.addListener(_jsListenerFunction);

      // Perform an initial check when the component first loads
      _updateActiveTheme();
    }
  }

  @override
  void didUpdateComponent(covariant JasprApp oldComponent) {
    super.didUpdateComponent(oldComponent);
    // Update active theme if relevant properties change
    if (component.themeMode != oldComponent.themeMode ||
        component.theme != oldComponent.theme ||
        component.darkTheme != oldComponent.darkTheme) {
      _updateActiveTheme();
    }
    // Update browser title if it changes
    if (component.title != oldComponent.title && kIsWeb) {
      document.title = component.title;
    }
  }

  @override
  void dispose() {
    _mediaQueryList.removeListener(_jsListenerFunction);
    super.dispose();
  }

  /// Determines and sets the active theme based on `themeMode` and system preference.
  void _updateActiveTheme() {
    ThemeData newActiveTheme;
    bool isSystemDark = false;
    if (kIsWeb) {
      isSystemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    }

    switch (component.themeMode) {
      case ThemeMode.light:
        newActiveTheme = component.theme;
        break;
      case ThemeMode.dark:
        newActiveTheme = component.darkTheme;
        break;
      case ThemeMode.system:
        newActiveTheme = isSystemDark ? component.darkTheme : component.theme;
        break;
    }
    setState(() {
      _activeTheme = newActiveTheme;
    });
    // Apply the 'dark' class to the <html> element for Tailwind/CSS variable overrides
    _applyDarkModeClass(newActiveTheme.brightness == Brightness.dark);
  }

  /// Adds or removes the 'dark' class on the <html> element.
  void _applyDarkModeClass(bool enableDark) {
    if (kIsWeb) {
      if (enableDark) {
        document.documentElement?.classList.add('dark');
        //document.documentElement?.dataset['colorScheme'] = 'dark'; // For better JS detection
      } else {
        document.documentElement?.classList.remove('dark');
        //document.documentElement?.dataset['colorScheme'] = 'light';
      }
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    if (_activeTheme == null) {
      // Show a loading indicator until the theme is determined
      yield const TextComponent('Loading application...');
      return;
    }

    // Inject global CSS variables into the `:root` element.
    // We define two sets of variables: one for light mode (default) and one for dark mode (within `.dark` scope).
    yield DomComponent(
      tag: 'style',
      children: [
        text('''
          /* Base Light Theme Variables (default) */
          :root {
            --primary-color: ${_activeTheme!.colorScheme.primary.value};
            --primary-variant-color: ${_activeTheme!.colorScheme.primaryVariant.value};
            --secondary-color: ${_activeTheme!.colorScheme.secondary.value};
            --secondary-variant-color: ${_activeTheme!.colorScheme.secondaryVariant.value};
            --surface-color: ${_activeTheme!.colorScheme.surface.value};
            --background-color: ${_activeTheme!.colorScheme.background.value};
            --error-color: ${_activeTheme!.colorScheme.error.value};

            --on-primary-color: ${_activeTheme!.colorScheme.onPrimary.value};
            --on-secondary-color: ${_activeTheme!.colorScheme.onSecondary.value};
            --on-surface-color: ${_activeTheme!.colorScheme.onSurface.value};
            --on-background-color: ${_activeTheme!.colorScheme.onBackground.value};
            --on-error-color: ${_activeTheme!.colorScheme.onError.value};

            --text-display-large-size: ${_activeTheme!.textTheme.displayLarge.fontSize}px;
            --text-display-large-weight: ${_activeTheme!.textTheme.displayLarge.fontWeight?.value};
            --text-display-large-color: ${_activeTheme!.textTheme.displayLarge.color?.value};

            /* Add more text theme variables here as needed */
            --font-family: ${_activeTheme!.fontFamily};
            --default-border-radius: ${_activeTheme!.defaultBorderRadius}px;
          }

          /* Dark Theme Overrides (applied when html.dark class is present) */
          html.dark {
            --primary-color: ${component.darkTheme.colorScheme.primary.value};
            --primary-variant-color: ${component.darkTheme.colorScheme.primaryVariant.value};
            --secondary-color: ${component.darkTheme.colorScheme.secondary.value};
            --secondary-variant-color: ${component.darkTheme.colorScheme.secondaryVariant.value};
            --surface-color: ${component.darkTheme.colorScheme.surface.value};
            --background-color: ${component.darkTheme.colorScheme.background.value};
            --error-color: ${component.darkTheme.colorScheme.error.value};

            --on-primary-color: ${component.darkTheme.colorScheme.onPrimary.value};
            --on-secondary-color: ${component.darkTheme.colorScheme.onSecondary.value};
            --on-surface-color: ${component.darkTheme.colorScheme.onSurface.value};
            --on-background-color: ${component.darkTheme.colorScheme.onBackground.value};
            --on-error-color: ${component.darkTheme.colorScheme.onError.value};

            --text-display-large-size: ${component.darkTheme.textTheme.displayLarge.fontSize}px;
            --text-display-large-weight: ${component.darkTheme.textTheme.displayLarge.fontWeight?.value};
            --text-display-large-color: ${component.darkTheme.textTheme.displayLarge.color?.value};

            --font-family: ${component.darkTheme.fontFamily};
            --default-border-radius: ${component.darkTheme.defaultBorderRadius}px;
          }

          /* Apply basic global styles to the html/body */
          html {
            color-scheme: light; /* Default scheme for browsers that respect it */
          }
          html.dark {
            color-scheme: dark;
          }

          body {
            font-family: var(--font-family);
            background-color: var(--background-color);
            color: var(--on-background-color);
            margin: 0;
            padding: 0;
            line-height: 1.5; /* Default line height for body */
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transition */
          }

          ${component.debugShowCheckedModeBanner ? '''
          /* Debug banner styles */
          .debug-banner {
            position: fixed;
            top: 0;
            right: 0;
            background-color: rgba(255, 0, 0, 0.6);
            color: white;
            padding: 4px 8px;
            font-size: 12px;
            font-family: sans-serif;
            z-index: 9999;
            pointer-events: none;
            user-select: none;
            opacity: 0.8;
          }
          ''' : ''}
        '''),
      ],
    );

    // Determine the child content (Router or home)
    Component appContent = Router(
      routes: List.from(component.routes),
    );

    // If 'home' is provided and no specific route exists for '/', add it to routes
    // This part is a bit tricky with jaspr_router. It's usually better to just
    // define '/' in your routes explicitly if you're using `home` as a concept.
    // However, if `home` is truly meant as a fallback, you might add it to routes
    // dynamically, or use a default route like `GoRoute(path: '/', builder: (_) => home)`.
    // For now, let's assume `home` is just a simple default route if routes are empty.
    if (component.routes.isEmpty && component.home != null) {
      appContent = component.home!;
    } else if (component.routes.isNotEmpty && component.home != null) {
      // If routes are provided, `home` is effectively ignored unless it's explicitly
      // added as a GoRoute(path: '/', builder: (_) => home).
      // We will let the Router handle routing, assuming '/' is defined in `routes` if needed.
    }

    // Apply the custom builder if provided
    if (component.builder != null) {
      appContent = component.builder!(context, appContent);
    }

    // Wrap with the debug banner if enabled
    if (component.debugShowCheckedModeBanner) {
      appContent = Stack(
        children: [
          appContent,
          div(classes: 'debug-banner', [text('DEBUG')]),
        ],
      );
    }

    // Provide the theme data to the rest of the component tree via InheritedComponent
    yield _ThemeInheritedComponent(
      themeData: _activeTheme!,
      child: appContent,
    );
  }
}
