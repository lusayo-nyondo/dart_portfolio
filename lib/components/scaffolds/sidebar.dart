import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart'; // Make sure this exports everything needed

/// Defines the display mode of a sidebar panel.
enum SidebarMode {
  expanded,
  overlay,
  collapsible,
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
  final Component child; // Main content area (default for the scaffold layout)
  final Component Function(BuildContext context, RouteState state,
      SidebarPanelState sidebarState)? sidebarBuilder;
  final Component Function(BuildContext context, RouteState state,
      SidebarPanelState detailBarState)? detailBarBuilder;
  final TextDirection direction; // ltr or rtl
  final Unit? sidebarMaxWidth;
  final Unit? detailBarMaxWidth;
  final Color? backgroundColor; // Optional background for the whole scaffold
  final SidebarPanelController? sidebarController;
  final SidebarPanelController? detailBarController;
  final List<RouteBase> routes; // Router routes

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
  // Store internal state for each sidebar
  SidebarPanelState _sidebarInternalState = const SidebarPanelState();
  SidebarPanelState _detailBarInternalState = const SidebarPanelState();
  RouteState? _previousRouteState; // To track route changes

  @override
  void initState() {
    super.initState();
    // Initialize internal states from controllers, or use defaults
    _sidebarInternalState =
        component.sidebarController?.state ?? _sidebarInternalState;
    _detailBarInternalState =
        component.detailBarController?.state ?? _detailBarInternalState;

    component.sidebarController?.addListener(_onSidebarControllerUpdate);
    component.detailBarController?.addListener(_onDetailBarControllerUpdate);
  }

  @override
  void didUpdateComponent(SidebarScaffold oldWidget) {
    super.didUpdateComponent(oldWidget);
    // Re-register listeners if controllers change
    if (oldWidget.sidebarController != component.sidebarController) {
      oldWidget.sidebarController?.removeListener(_onSidebarControllerUpdate);
      component.sidebarController?.addListener(_onSidebarControllerUpdate);
    }
    if (oldWidget.detailBarController != component.detailBarController) {
      oldWidget.detailBarController
          ?.removeListener(_onDetailBarControllerUpdate);
      component.detailBarController?.addListener(_onDetailBarControllerUpdate);
    }
    // Update internal states if new controllers or their initial states are different
    _sidebarInternalState =
        component.sidebarController?.state ?? _sidebarInternalState;
    _detailBarInternalState =
        component.detailBarController?.state ?? _detailBarInternalState;
  }

  @override
  void dispose() {
    component.sidebarController?.removeListener(_onSidebarControllerUpdate);
    component.detailBarController?.removeListener(_onDetailBarControllerUpdate);
    super.dispose();
  }

  void _onSidebarControllerUpdate() {
    setState(() {
      _sidebarInternalState = component.sidebarController!.state;
    });
  }

  void _onDetailBarControllerUpdate() {
    setState(() {
      _detailBarInternalState = component.detailBarController!.state;
    });
  }

  // Getters for the *effective* state of each sidebar, considering builder presence
  SidebarPanelState get _effectiveSidebarState {
    final stateFromController =
        component.sidebarController?.state ?? _sidebarInternalState;
    return component.sidebarBuilder == null
        ? stateFromController.copyWith(isVisible: false)
        : stateFromController;
  }

  SidebarPanelState get _effectiveDetailBarState {
    final stateFromController =
        component.detailBarController?.state ?? _detailBarInternalState;
    return component.detailBarBuilder == null
        ? stateFromController.copyWith(isVisible: false)
        : stateFromController;
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final sidebarPanelState = _effectiveSidebarState;
    final detailBarPanelState = _effectiveDetailBarState;

    final bool showSidebar = sidebarPanelState.isVisible;
    final bool showDetailBar = detailBarPanelState.isVisible;

    const Unit defaultSidebarMaxWidth = Unit.pixels(240); // Consistent name
    const Unit defaultDetailBarMaxWidth = Unit.pixels(240); // Consistent name

    final Unit effectiveSidebarMaxWidth =
        component.sidebarMaxWidth ?? defaultSidebarMaxWidth;
    final Unit effectiveDetailBarMaxWidth =
        component.detailBarMaxWidth ?? defaultDetailBarMaxWidth;

    yield Container(
      constraints: BoxConstraints(
        minHeight: 100.percent,
        minWidth: 100.percent,
      ),
      child: Router(
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              // *** ROUTE LISTENER LOGIC ***
              if (_previousRouteState == null) {
                print('Route changed: Initial route: ${state.location}');
              } else if (_previousRouteState!.location != state.location) {
                print(
                    'Route changed: From ${_previousRouteState!.location} to ${state.location}');
              }
              _previousRouteState =
                  state; // Update the previous state for the next comparison

              print("Current route in sidebar scaffold shell: ${state.path}");
              // *** END ROUTE LISTENER LOGIC ***

              final List<Component> inFlowChildren = [];
              final List<Component> overlayChildren = [];

              // 1. Build and conditionally add Sidebar
              if (showSidebar) {
                final sidebarContent = component.sidebarBuilder!(
                    context, state, sidebarPanelState);
                final sidebarContainer = Container(
                  constraints:
                      BoxConstraints(maxWidth: effectiveSidebarMaxWidth),
                  height: (sidebarPanelState.mode == SidebarMode.overlay)
                      ? 100.vh
                      : null,
                  child: div(
                    [sidebarContent],
                    styles: (sidebarPanelState.mode == SidebarMode.overlay)
                        ? Styles(
                            position: Position.absolute(
                              top: 0.px,
                              bottom: 0.px,
                              left: component.direction == TextDirection.ltr
                                  ? 0.px
                                  : null,
                              right: component.direction == TextDirection.rtl
                                  ? 0.px
                                  : null,
                            ),
                            zIndex: ZIndex(10), // Ensure overlay is on top
                          )
                        : null, // No specific styles for in-flow in this container,
                  ),
                );

                if (sidebarPanelState.mode == SidebarMode.overlay) {
                  overlayChildren.add(sidebarContainer);
                } else {
                  inFlowChildren.add(sidebarContainer);
                }
              }

              // 2. Main Content (child from ShellRoute)
              final mainContent = Expanded(
                child:
                    child, // <--- CORRECTED: This `child` is the routed content
              );

              // 3. Build and conditionally add Detail Bar
              if (showDetailBar) {
                final detailBarContent = component.detailBarBuilder!(
                    context, state, detailBarPanelState);
                final detailBarContainer = Container(
                  constraints:
                      BoxConstraints(maxWidth: effectiveDetailBarMaxWidth),
                  height: (detailBarPanelState.mode == SidebarMode.overlay)
                      ? 100.vh
                      : null,
                  // No specific styles for in-flow in this container
                  child: div([detailBarContent],
                      styles: (detailBarPanelState.mode == SidebarMode.overlay)
                          ? Styles(
                              position: Position.absolute(
                                top: 0.px,
                                bottom: 0.px,
                                right: component.direction == TextDirection.ltr
                                    ? 0.px
                                    : null,
                                left: component.direction == TextDirection.rtl
                                    ? 0.px
                                    : null,
                              ),
                              zIndex: ZIndex(10),
                            )
                          : null),
                );

                if (detailBarPanelState.mode == SidebarMode.overlay) {
                  overlayChildren.add(detailBarContainer);
                } else {
                  inFlowChildren.add(detailBarContainer);
                }
              }

              // 4. Assemble in-flow children based on direction
              // Clear and re-add for clarity
              final List<Component> finalInFlowChildren = [];

              if (component.direction == TextDirection.ltr) {
                if (inFlowChildren.isNotEmpty &&
                    sidebarPanelState.mode != SidebarMode.overlay) {
                  finalInFlowChildren.add(
                      inFlowChildren[0]); // Assumes sidebar is first if present
                }
                finalInFlowChildren.add(mainContent);
                if (inFlowChildren.length > 1 &&
                    detailBarPanelState.mode != SidebarMode.overlay) {
                  finalInFlowChildren.add(inFlowChildren[
                      1]); // Assumes detailbar is second if present
                }
              } else {
                // RTL
                if (inFlowChildren.length > 1 &&
                    detailBarPanelState.mode != SidebarMode.overlay) {
                  finalInFlowChildren
                      .add(inFlowChildren[1]); // Detailbar comes first in RTL
                }
                finalInFlowChildren.add(mainContent);
                if (inFlowChildren.isNotEmpty &&
                    sidebarPanelState.mode != SidebarMode.overlay) {
                  finalInFlowChildren
                      .add(inFlowChildren[0]); // Sidebar comes last in RTL
                }
              }

              return DomComponent(
                tag: 'div',
                styles: Styles(
                  width: 100.percent,
                  height: 100.vh,
                  backgroundColor: component.backgroundColor,
                  position: Position
                      .relative(), // Establishes stacking context for overlays
                  display:
                      Display.flex, // Ensure the children are laid out by Row
                  flexDirection: FlexDirection.row, // Matches Row's behavior
                ),
                children: [
                  Row(
                    // This Row now acts as the primary layout for in-flow elements
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: finalInFlowChildren,
                  ),
                  // Overlays are absolutely positioned on top of the Row
                  ...overlayChildren,
                ],
              );
            },
            routes: component.routes, // Use the routes passed to the component
          ),
        ],
      ),
    );
  }
}
