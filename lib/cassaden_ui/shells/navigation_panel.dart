import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../cassaden_ui.dart';

/// Defines the display mode of a sidebar panel.
enum NavigationPanelMode {
  expanded,
  overlay,
  collapsible,
  responsive,
}

/// Represents the state of a sidebar panel.
class NavigationPanelState {
  final bool isVisible;
  final NavigationPanelMode mode;

  const NavigationPanelState({
    this.isVisible = true,
    this.mode = NavigationPanelMode.expanded,
  });

  NavigationPanelState copyWith({
    bool? isVisible,
    NavigationPanelMode? mode,
  }) {
    return NavigationPanelState(
      isVisible: isVisible ?? this.isVisible,
      mode: mode ?? this.mode,
    );
  }
}

/// Controller to manage the state of a sidebar panel.
class NavigationPanelController {
  NavigationPanelState _state;
  void Function()? _listener;

  NavigationPanelController(
      {NavigationPanelState initialState = const NavigationPanelState()})
      : _state = initialState;

  NavigationPanelState get state => _state;
  bool get isVisible => _state.isVisible;
  NavigationPanelMode get mode => _state.mode;

  void show() {
    if (!_state.isVisible) {
      _state = _state.copyWith(isVisible: true);
      _notifyListeners();
    }
  }

  void hide() {
    if (_state.isVisible) {
      _state = _state.copyWith(isVisible: false);
      _notifyListeners();
    }
  }

  void toggle() {
    print("Navbar controller toggled.");
    _state = _state.copyWith(isVisible: !_state.isVisible);
    _notifyListeners();
  }

  void setMode(NavigationPanelMode mode) {
    if (_state.mode != mode) {
      _state = _state.copyWith(mode: mode);
      _notifyListeners();
    }
  }

  void updateState(NavigationPanelState newState) {
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

class _NavigationPanelShellLayout extends StatefulComponent {
  final Component routerChild;
  final RouteState routeState;
  final Component Function(BuildContext context, RouteState state,
      NavigationPanelState sidebarState)? sidebarBuilder;
  final Component Function(BuildContext context, RouteState state,
      NavigationPanelState detailBarState)? detailBarBuilder;
  final TextDirection direction;
  final Unit? sidebarMaxWidth;
  final Unit? detailBarMaxWidth;
  final Color? backgroundColor;
  final NavigationPanelController? sidebarController;
  final NavigationPanelController? detailBarController;

  const _NavigationPanelShellLayout({
    required this.routerChild,
    required this.routeState,
    this.sidebarBuilder,
    this.detailBarBuilder,
    this.direction = TextDirection.ltr,
    this.sidebarMaxWidth,
    this.detailBarMaxWidth,
    this.backgroundColor,
    this.sidebarController,
    this.detailBarController,
  });

  @override
  State<_NavigationPanelShellLayout> createState() =>
      _NavigationPanelShellLayoutState();
}

class _NavigationPanelShellLayoutState
    extends State<_NavigationPanelShellLayout> {
  NavigationPanelState _sidebarInternalState = const NavigationPanelState();
  NavigationPanelState _detailBarInternalState = const NavigationPanelState();
  // RouteState? _previousRouteState; // For route change listening if needed explicitly

  @override
  void initState() {
    super.initState();
    _sidebarInternalState =
        component.sidebarController?.state ?? _sidebarInternalState;
    _detailBarInternalState =
        component.detailBarController?.state ?? _detailBarInternalState;

    component.sidebarController
        ?.addListener(_onNavigationPanelControllerUpdate);
    component.detailBarController?.addListener(_onDetailBarControllerUpdate);
    // _previousRouteState = component.routeState;
  }

  @override
  void didUpdateComponent(_NavigationPanelShellLayout oldWidget) {
    super.didUpdateComponent(oldWidget);
    if (oldWidget.sidebarController != component.sidebarController) {
      oldWidget.sidebarController
          ?.removeListener(_onNavigationPanelControllerUpdate);
      component.sidebarController
          ?.addListener(_onNavigationPanelControllerUpdate);
      _sidebarInternalState =
          component.sidebarController?.state ?? const NavigationPanelState();
    }
    if (oldWidget.detailBarController != component.detailBarController) {
      oldWidget.detailBarController
          ?.removeListener(_onDetailBarControllerUpdate);
      component.detailBarController?.addListener(_onDetailBarControllerUpdate);
      _detailBarInternalState =
          component.detailBarController?.state ?? const NavigationPanelState();
    }

    // if (component.routeState.location != _previousRouteState?.location) {
    //   print('Route changed in _NavigationPanelShellLayout: From ${_previousRouteState?.location} to ${component.routeState.location}');
    //   _previousRouteState = component.routeState;
    // }
  }

  @override
  void dispose() {
    component.sidebarController
        ?.removeListener(_onNavigationPanelControllerUpdate);
    component.detailBarController?.removeListener(_onDetailBarControllerUpdate);
    super.dispose();
  }

  void _onNavigationPanelControllerUpdate() {
    setState(() {
      _sidebarInternalState = component.sidebarController!.state;
    });
  }

  void _onDetailBarControllerUpdate() {
    setState(() {
      _detailBarInternalState = component.detailBarController!.state;
    });
  }

  NavigationPanelState get _effectiveNavigationPanelState {
    final stateFromController =
        component.sidebarController?.state ?? _sidebarInternalState;
    return component.sidebarBuilder == null
        ? stateFromController.copyWith(isVisible: false)
        : stateFromController;
  }

  NavigationPanelState get _effectiveDetailBarState {
    final stateFromController =
        component.detailBarController?.state ?? _detailBarInternalState;
    return component.detailBarBuilder == null
        ? stateFromController.copyWith(isVisible: false)
        : stateFromController;
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final sidebarPanelState = _effectiveNavigationPanelState;
    final detailBarPanelState = _effectiveDetailBarState;

    final bool showNavigationPanel = sidebarPanelState.isVisible;
    final bool showDetailBar = detailBarPanelState.isVisible;

    const Unit defaultNavigationPanelMaxWidth = Unit.pixels(240);
    const Unit defaultDetailBarMaxWidth = Unit.pixels(240);

    final Unit effectiveNavigationPanelMaxWidth =
        component.sidebarMaxWidth ?? defaultNavigationPanelMaxWidth;
    final Unit effectiveDetailBarMaxWidth =
        component.detailBarMaxWidth ?? defaultDetailBarMaxWidth;

    final List<Component> inFlowChildren = [];
    final List<Component> overlayChildren = [];

    if (showNavigationPanel && component.sidebarBuilder != null) {
      final sidebarContent = component.sidebarBuilder!(
          context, component.routeState, sidebarPanelState);
      final sidebarContainer = Container(
        constraints: BoxConstraints(maxWidth: effectiveNavigationPanelMaxWidth),
        height: (sidebarPanelState.mode == NavigationPanelMode.overlay)
            ? 100.vh
            : null,
        child: div(
          classes: 'h-full w-full',
          [sidebarContent],
          styles: (sidebarPanelState.mode == NavigationPanelMode.overlay)
              ? Styles(
                  position: Position.absolute(
                      top: 0.px,
                      bottom: 0.px,
                      left: component.direction == TextDirection.ltr
                          ? 0.px
                          : null,
                      right: component.direction == TextDirection.rtl
                          ? 0.px
                          : null),
                  zIndex: ZIndex(10))
              : null,
        ),
      );
      if (sidebarPanelState.mode == NavigationPanelMode.overlay) {
        overlayChildren.add(sidebarContainer);
      } else {
        inFlowChildren.add(sidebarContainer);
      }
    }

    final mainContent = Expanded(child: component.routerChild);

    if (showDetailBar && component.detailBarBuilder != null) {
      final detailBarContent = component.detailBarBuilder!(
          context, component.routeState, detailBarPanelState);
      final detailBarContainer = Container(
        constraints: BoxConstraints(maxWidth: effectiveDetailBarMaxWidth),
        height: (detailBarPanelState.mode == NavigationPanelMode.overlay)
            ? 100.vh
            : null,
        child: div(
            classes: 'h-full w-full',
            [detailBarContent],
            styles: (detailBarPanelState.mode == NavigationPanelMode.overlay)
                ? Styles(
                    position: Position.absolute(
                        top: 0.px,
                        bottom: 0.px,
                        right: component.direction == TextDirection.ltr
                            ? 0.px
                            : null,
                        left: component.direction == TextDirection.rtl
                            ? 0.px
                            : null),
                    zIndex: ZIndex(10))
                : null),
      );
      if (detailBarPanelState.mode == NavigationPanelMode.overlay) {
        overlayChildren.add(detailBarContainer);
      } else {
        inFlowChildren.add(detailBarContainer);
      }
    }

    final List<Component> finalInFlowChildren = [];
    if (component.direction == TextDirection.ltr) {
      if (showNavigationPanel &&
          sidebarPanelState.mode != NavigationPanelMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.firstWhere((c) => true,
            orElse: () =>
                DomComponent(tag: 'span'))); // Placeholder if not found
      }
      finalInFlowChildren.add(mainContent);
      if (showDetailBar &&
          detailBarPanelState.mode != NavigationPanelMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.lastWhere((c) => true,
            orElse: () => DomComponent(tag: 'span')));
      }
    } else {
      // RTL
      if (showDetailBar &&
          detailBarPanelState.mode != NavigationPanelMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.firstWhere((c) => true,
            orElse: () => DomComponent(tag: 'span')));
      }
      finalInFlowChildren.add(mainContent);
      if (showNavigationPanel &&
          sidebarPanelState.mode != NavigationPanelMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.lastWhere((c) => true,
            orElse: () => DomComponent(tag: 'span')));
      }
    }

    yield DomComponent(
      tag: 'div',
      styles: Styles(
        width: 100.percent,
        height: 100.vh,
        backgroundColor: component.backgroundColor,
        position: Position.relative(),
        display: Display.flex,
        flexDirection: FlexDirection.row,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: finalInFlowChildren,
        ),
        ...overlayChildren,
      ],
    );
  }
}

class NavigationPanelShell extends ShellRoute {
  NavigationPanelShell({
    required super.routes,
    Component Function(BuildContext context, RouteState state,
            NavigationPanelState sidebarState)?
        sidebarBuilder,
    Component Function(BuildContext context, RouteState state,
            NavigationPanelState detailBarState)?
        detailBarBuilder,
    TextDirection direction = TextDirection.ltr,
    Unit? sidebarMaxWidth,
    Unit? detailBarMaxWidth,
    Color? backgroundColor,
    NavigationPanelController? sidebarController,
    NavigationPanelController? detailBarController,
    Object?
        navigatorKey, // Retain if needed for advanced Jaspr routing scenarios
  }) : super(
          builder: (context, state, child) => _NavigationPanelShellLayout(
            routerChild: child,
            routeState: state,
            sidebarBuilder: sidebarBuilder,
            detailBarBuilder: detailBarBuilder,
            direction: direction,
            sidebarMaxWidth: sidebarMaxWidth,
            detailBarMaxWidth: detailBarMaxWidth,
            backgroundColor: backgroundColor,
            sidebarController: sidebarController,
            detailBarController: detailBarController,
          ),
          // navigatorKey: navigatorKey, // Pass if used
        );
}
