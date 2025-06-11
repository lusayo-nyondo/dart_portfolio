import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

// Assuming these are your components
import '../components.dart';
import 'header.dart';
import 'footer.dart';

class HeaderFooterScaffold extends StatefulComponent {
  final List<RouteBase> routes;
  final Component Function(BuildContext context, RouteState state)?
      headerBuilder;
  final Component Function(BuildContext context, RouteState state)?
      footerBuilder;

  const HeaderFooterScaffold({
    required this.routes,
    this.headerBuilder,
    this.footerBuilder,
    super.key,
  });

  @override
  State<HeaderFooterScaffold> createState() => _HeaderFooterScaffoldState();
}

class _HeaderFooterScaffoldState extends State<HeaderFooterScaffold> {
  // Store the previous RouteState to compare
  RouteState? _previousRouteState;

  @override
  void initState() {
    super.initState();
    // Initialize previous state if needed, though the first build will set it
  }

  // The actual "listener" logic will be inside the builder
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Container(
      constraints: BoxConstraints(
        minHeight: 100.vh,
      ),
      child: Router(routes: [
        ShellRoute(
          builder: (context, state, child) {
            // This 'builder' acts as your route listener
            if (_previousRouteState == null) {
              // Initial route
              print('Route changed: Initial route: ${state.location}');
            } else if (_previousRouteState!.location != state.location) {
              // Route location has changed
              print(
                  'Route changed: From ${_previousRouteState!.location} to ${state.location}');
              // You can check other properties of state as well, e.g., state.uri.queryParameters, etc.
              // For 'isChanging' (route transition started), this builder would be called.
              // For 'changed' (route transition finished), this builder would be called after the new route is fully resolved.
              // Jaspr's router typically re-renders the builder with the new state once the change is processed.
            }

            // Update the previous state for the next comparison
            _previousRouteState = state;

            return Column(children: [
              // Use the headerBuilder if provided, otherwise default Header
              component.headerBuilder != null
                  ? component.headerBuilder!(context, state)
                  : Header(),
              Expanded(
                child: child,
              ),
              // Use the footerBuilder if provided, otherwise default Footer
              component.footerBuilder != null
                  ? component.footerBuilder!(context, state)
                  : Footer(),
            ]);
          },
          routes: component.routes, // Use the routes passed to the component
        ),
      ]),
    );
  }
}
