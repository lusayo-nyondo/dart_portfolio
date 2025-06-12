import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

// Assuming '../components.dart' exports Container, Row, Column, Expanded, NavLink etc.
// And also Color, Unit, Styles, Padding, Alignment etc.
import '../components.dart';
import 'footer.dart';

/// Defines the visual and navigation properties of a single tab.
class TabBarItem {
  /// The path this tab navigates to. Must correspond to a defined route.
  final String path;

  /// The visual representation of the tab, typically text or an icon with text.
  final Component label;

  /// An optional icon for the tab.
  final Component? icon;

  const TabBarItem({
    required this.path,
    required this.label,
    this.icon,
  });
}

/// Defines the orientation and position of the tab bar.
enum TabOrientation {
  horizontalTop,
  horizontalBottom,
  verticalLeft,
  verticalRight,
}

/// A scaffold that provides tab-based navigation.
///
/// The `TabbedScaffold` uses a `ShellRoute` to manage the layout,
/// displaying a tab bar and the content for the currently active tab.
class TabbedScaffold extends StatefulComponent {
  /// A list of [TabBarItem] objects defining the properties of each tab.
  final List<TabBarItem> tabBarItems;

  /// The routes that define the content for each tab and any other navigation.
  /// The paths in [tabBarItems] must correspond to paths defined in these routes.
  final List<RouteBase> routes;

  /// A builder function responsible for rendering the tab bar UI.
  /// It receives the build context, current route state, and the list of [tabBarItems].
  final Component Function(
    BuildContext context,
    RouteState routeState,
    List<TabBarItem> tabBarItems,
  ) tabBarBuilder;

  /// The orientation and position of the tab bar. Defaults to [TabOrientation.horizontalTop].
  final TabOrientation orientation;

  /// An optional builder for a footer component. If null, a default [Footer] is used.
  final Component Function(BuildContext context, RouteState state)?
      footerBuilder;

  /// Optional background color for the entire scaffold.
  final Color? backgroundColor;

  /// Optional styles to apply to the container that wraps the tab bar.
  final Styles? tabBarContainerStyles;

  /// Optional styles to apply to the container that wraps the routed child content.
  final Styles? contentContainerStyles;

  const TabbedScaffold({
    required this.tabBarItems,
    required this.routes,
    required this.tabBarBuilder,
    this.orientation = TabOrientation.horizontalTop,
    this.footerBuilder,
    this.backgroundColor,
    this.tabBarContainerStyles,
    this.contentContainerStyles,
    super.key,
  });

  @override
  State<TabbedScaffold> createState() => _TabbedScaffoldState();
}

class _TabbedScaffoldState extends State<TabbedScaffold> {
  RouteState? _previousRouteState; // For potential route change logic if needed

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      // Full viewport container
      constraints: BoxConstraints(minHeight: 100.vh, minWidth: 100.vw),
      color: component.backgroundColor,
      child: Router(
        routes: [
          ShellRoute(
            builder: (context, routeState, child) {
              // Route change detection (optional, for logging or side effects)
              if (_previousRouteState == null) {
                // print('TabbedScaffold: Initial route: ${routeState.location}');
              } else if (_previousRouteState!.location != routeState.location) {
                // print('TabbedScaffold: Route changed from ${_previousRouteState!.location} to ${routeState.location}');
              }
              _previousRouteState = routeState;

              final tabBar = DomComponent(
                tag: 'nav', // Semantic tag for navigation
                styles: component.tabBarContainerStyles,
                child: component.tabBarBuilder(
                  context,
                  routeState,
                  component.tabBarItems,
                ),
              );

              final content = Expanded(
                child: div(
                  styles: component.contentContainerStyles,
                  // The routed child content itself might have its own background.
                  // If contentContainerStyles includes a background, it will apply here.
                  [child], // This is the routed page content
                ),
              );

              final footer = component.footerBuilder != null
                  ? component.footerBuilder!(context, routeState)
                  : Footer(); // Default footer

              switch (component.orientation) {
                case TabOrientation.horizontalTop:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      tabBar,
                      content,
                      footer,
                    ],
                  );
                case TabOrientation.horizontalBottom:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      content,
                      tabBar,
                      footer,
                    ],
                  );
                case TabOrientation.verticalLeft:
                  return Column(
                    // Outer column for footer
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            tabBar,
                            content,
                          ],
                        ),
                      ),
                      footer,
                    ],
                  );
                case TabOrientation.verticalRight:
                  return Column(
                    // Outer column for footer
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            content,
                            tabBar,
                          ],
                        ),
                      ),
                      footer,
                    ],
                  );
              }
            },
            routes: component.routes,
          ),
        ],
      ),
    );
  }
}
