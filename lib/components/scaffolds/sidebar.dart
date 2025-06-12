import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

// Assuming '../components.dart' exports:
// - Container (from lib/components/containers/container.dart)
// - Row (from lib/components/containers/flexbox/row.dart)
// - BoxConstraints (from lib/components/containers/box_model/box_constraints.dart)
// Expanded, Unit, Color, TextDirection are from 'package:jaspr/jaspr.dart'.
// Expanded, Unit, Color, TextDirection are from 'package:jaspr/jaspr.dart'.
import '../components.dart';

/// Defines the display mode of a sidebar panel.
enum SidebarMode {
  /// Takes up space in the layout, always visible if `isVisible` is true.
  expanded,

  /// Floats on top of the main content.
  overlay,

  /// Can be shown or hidden, takes up space in the layout when visible.
  collapsible,

  /// Behavior might change based on screen size (typically managed by the builder).
  /// In terms of layout contribution, it's treated like 'expanded' or 'collapsible'.
  responsive,
}

/// Represents the state of a sidebar panel.
class SidebarPanelState {
  final bool isVisible;
  final SidebarMode mode;

  const SidebarPanelState({
    this.isVisible = true,
    this.mode = SidebarMode.expanded,
  });

  SidebarPanelState copyWith({
    bool? isVisible,
    SidebarMode? mode,
  }) {
    return SidebarPanelState(
      isVisible: isVisible ?? this.isVisible,
      mode: mode ?? this.mode,
    );
  }
}

/// Controller to manage the state of a sidebar panel.
class SidebarPanelController {
  SidebarPanelState _state;
  void Function()? _listener;

  SidebarPanelController(
      {SidebarPanelState initialState = const SidebarPanelState()})
      : _state = initialState;

  /// The current state of the panel.
  SidebarPanelState get state => _state;

  /// Whether the panel is currently set to be visible.
  bool get isVisible => _state.isVisible;

  /// The current display mode of the panel.
  SidebarMode get mode => _state.mode;

  /// Shows the panel.
  void show() {
    if (!_state.isVisible) {
      _state = _state.copyWith(isVisible: true);
      _notifyListeners();
    }
  }

  /// Hides the panel.
  void hide() {
    if (_state.isVisible) {
      _state = _state.copyWith(isVisible: false);
      _notifyListeners();
    }
  }

  /// Toggles the visibility of the panel.
  void toggle() {
    _state = _state.copyWith(isVisible: !_state.isVisible);
    _notifyListeners();
  }

  /// Sets the display mode of the panel.
  void setMode(SidebarMode mode) {
    if (_state.mode != mode) {
      _state = _state.copyWith(mode: mode);
      _notifyListeners();
    }
  }

  /// Directly updates the panel's state.
  void updateState(SidebarPanelState newState) {
    if (_state.isVisible != newState.isVisible ||
        _state.mode != newState.mode) {
      _state = newState;
      _notifyListeners();
    }
  }

  void addListener(void Function() listener) {
    // For simplicity, this controller supports one listener,
    // suitable for the scaffold's internal use.
    _listener = listener;
  }

  void removeListener(void Function() listener) {
    if (_listener == listener) {
      _listener = null;
    }
  }

  void _notifyListeners() {
    _listener?.call();
  }
}

class SidebarScaffold extends StatefulComponent {
  final Component child; // Main content area
  final Component Function(
      BuildContext context, SidebarPanelState sidebarState)? sidebarBuilder;
  final Component Function(
      BuildContext context, SidebarPanelState detailBarState)? detailBarBuilder;
  final TextDirection direction; // ltr or rtl
  final Unit? sidebarMaxWidth;
  final Unit? detailBarMaxWidth;
  final Color? backgroundColor; // Optional background for the whole scaffold
  final SidebarPanelController? sidebarController;
  final SidebarPanelController? detailBarController;
  final List<RouteBase> routes;

  const SidebarScaffold({
    required this.child,
    this.sidebarBuilder,
    this.detailBarBuilder,
    this.direction = TextDirection.ltr,
    this.sidebarMaxWidth,
    this.detailBarMaxWidth,
    this.backgroundColor,
    this.sidebarController,
    this.detailBarController,
    required this.routes,
    super.key,
  });

  @override
  State<SidebarScaffold> createState() => _SidebarScaffoldState();
}

class _SidebarScaffoldState extends State<SidebarScaffold> {
  SidebarPanelState _state = SidebarPanelState();
  RouteState? _previousRouteState;

  @override
  void initState() {
    super.initState();
    component.sidebarController?.addListener(_onControllerUpdate);
    component.detailBarController?.addListener(_onControllerUpdate);
  }

  @override
  void didUpdateComponent(SidebarScaffold oldWidget) {
    super.didUpdateComponent(oldWidget);
    if (oldWidget.sidebarController != component.sidebarController) {
      oldWidget.sidebarController?.removeListener(_onControllerUpdate);
      component.sidebarController?.addListener(_onControllerUpdate);
    }
    if (oldWidget.detailBarController != component.detailBarController) {
      oldWidget.detailBarController?.removeListener(_onControllerUpdate);
      component.detailBarController?.addListener(_onControllerUpdate);
    }
  }

  @override
  void dispose() {
    component.sidebarController?.removeListener(_onControllerUpdate);
    component.detailBarController?.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {
      _state = component.sidebarController?.state ??
          component.detailBarController?.state ??
          _state;
    });
  }

  SidebarPanelState get _currentSidebarState {
    if (component.sidebarController != null) {
      var state = component.sidebarController!.state;
      // Ensure panel is not visible if no builder is provided
      return component.sidebarBuilder == null
          ? state.copyWith(isVisible: false)
          : state;
    }
    // No controller
    return component.sidebarBuilder != null
        ? const SidebarPanelState(
            isVisible: true,
            mode: SidebarMode.expanded) // Default for present builder
        : const SidebarPanelState(
            isVisible: false,
            mode: SidebarMode.expanded); // Default for absent builder
  }

  SidebarPanelState get _currentDetailBarState {
    if (component.detailBarController != null) {
      var state = component.detailBarController!.state;
      return component.detailBarBuilder == null
          ? state.copyWith(isVisible: false)
          : state;
    }
    return component.detailBarBuilder != null
        ? const SidebarPanelState(isVisible: true, mode: SidebarMode.expanded)
        : const SidebarPanelState(isVisible: false, mode: SidebarMode.expanded);
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final List<Component> rowChildren = [];
    final sidebarPanelState = _currentSidebarState;
    final detailBarPanelState = _currentDetailBarState;

    final bool showSidebar =
        component.sidebarBuilder != null && sidebarPanelState.isVisible;
    final bool showDetailBar =
        component.detailBarBuilder != null && detailBarPanelState.isVisible;

    const Unit defaultSidebarMaxWidth = Unit.pixels(240);

    final Unit effectiveSidebarMaxWidth =
        component.sidebarMaxWidth ?? defaultSidebarMaxWidth;
    component.sidebarMaxWidth ?? defaultSidebarMaxWidth;
    final Unit effectiveDetailBarMaxWidth =
        component.detailBarMaxWidth ?? defaultSidebarMaxWidth;

    Component? actualSidebar;
    if (component.sidebarBuilder != null) {
      actualSidebar = Container(
        constraints: BoxConstraints(maxWidth: effectiveSidebarMaxWidth),
        // The child of this container (the actual sidebar content)
        // should define its own background/styling if needed.
        // This container is primarily for width constraint.
        child: component.sidebarBuilder!(context, _state),
      );
    }

    Component? actualDetailBar;
    if (component.detailBarBuilder != null) {
      actualDetailBar = Container(
        constraints: BoxConstraints(maxWidth: effectiveDetailBarMaxWidth),
        child: component.detailBarBuilder!(context, _state),
      );
    }

    // The main content should expand to fill available space.
    final mainContent = Expanded(
      child: component.child,
    );

    if (component.direction == TextDirection.ltr) {
      if (actualSidebar != null) {
        rowChildren.add(actualSidebar);
      }
      rowChildren.add(mainContent); // Main content is always present
      if (actualDetailBar != null) {
        rowChildren.add(actualDetailBar);
        component.detailBarMaxWidth ?? defaultSidebarMaxWidth;

        final List<Component> inFlowChildren = [];
        final List<Component> overlayChildren = [];

        // Build Sidebar
        if (showSidebar) {
          final sidebarContent =
              component.sidebarBuilder!(context, sidebarPanelState);
          final sidebarContainer = Container(
            constraints: BoxConstraints(maxWidth: effectiveSidebarMaxWidth),
            height:
                (sidebarPanelState.mode == SidebarMode.overlay) ? 100.vh : null,
            child: sidebarContent,
          );

          if (sidebarPanelState.mode == SidebarMode.overlay) {
            overlayChildren.add(
              DomComponent(
                tag: 'div',
                styles: Styles(
                  position: Position.absolute(
                    top: 0.px,
                    bottom: 0.px,
                    left:
                        component.direction == TextDirection.ltr ? 0.px : null,
                    right:
                        component.direction == TextDirection.rtl ? 0.px : null,
                  ),

                  zIndex: ZIndex(10), // Ensure overlay is on top
                ),
                child: sidebarContainer,
              ),
            );
          } else {
            // expanded, collapsible (when visible), responsive
            inFlowChildren.add(sidebarContainer);
          }
        }

        // Main Content - always present in the in-flow list
        final mainContent = Expanded(child: component.child);

        // Build Detail Bar
        Component? detailBarForInFlow;
        if (showDetailBar) {
          final detailBarContent =
              component.detailBarBuilder!(context, detailBarPanelState);
          final detailBarContainer = Container(
            constraints: BoxConstraints(maxWidth: effectiveDetailBarMaxWidth),
            height: (detailBarPanelState.mode == SidebarMode.overlay)
                ? 100.vh
                : null,
            child: detailBarContent,
          );

          if (detailBarPanelState.mode == SidebarMode.overlay) {
            overlayChildren.add(
              DomComponent(
                tag: 'div',
                styles: Styles(
                  position: Position.absolute(
                    top: 0.px,
                    bottom: 0.px,
                    right:
                        component.direction == TextDirection.ltr ? 0.px : null,
                    left:
                        component.direction == TextDirection.rtl ? 0.px : null,
                  ),
                  zIndex: ZIndex(10),
                ),
                child: detailBarContainer,
              ),
            );
          } else {
            // expanded, collapsible (when visible), responsive
            detailBarForInFlow = detailBarContainer;
          }
        }

        // Assemble in-flow children based on direction
        final List<Component> finalInFlowChildren = [];
        if (component.direction == TextDirection.ltr) {
          if (inFlowChildren.isNotEmpty) {
            finalInFlowChildren.add(inFlowChildren.first); // Sidebar
          }
          finalInFlowChildren.add(mainContent);
          if (detailBarForInFlow != null) {
            finalInFlowChildren.add(detailBarForInFlow);
          }
        } else {
          // RTL
          if (detailBarForInFlow != null) {
            finalInFlowChildren.add(detailBarForInFlow);
          }
          finalInFlowChildren.add(mainContent);
          if (inFlowChildren.isNotEmpty) {
            finalInFlowChildren.add(inFlowChildren.first); // Sidebar
          }
        }

        yield Container(
          constraints: BoxConstraints(
            minHeight: 100.percent,
            minWidth: 100.percent,
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

                return DomComponent(
                  tag: 'div',
                  styles: Styles(
                    width: 100.percent,
                    height: 100.vh,
                    backgroundColor: component.backgroundColor,
                    position: Position
                        .relative(), // Establishes stacking context for overlays
                  ),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: finalInFlowChildren,
                    ),
                    ...overlayChildren,
                  ],
                );
              },
              routes:
                  component.routes, // Use the routes passed to the component
            ),
          ]),
        );
      }
    }
  }
}
