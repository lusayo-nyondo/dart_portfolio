import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

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

  SidebarPanelState get state => _state;
  bool get isVisible => _state.isVisible;
  SidebarMode get mode => _state.mode;

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
    _state = _state.copyWith(isVisible: !_state.isVisible);
    _notifyListeners();
  }

  void setMode(SidebarMode mode) {
    if (_state.mode != mode) {
      _state = _state.copyWith(mode: mode);
      _notifyListeners();
    }
  }

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

class _SidebarShellLayout extends StatefulComponent {
  final Component routerChild;
  final RouteState routeState;
  final Component Function(BuildContext context, RouteState state,
      SidebarPanelState sidebarState)? sidebarBuilder;
  final Component Function(BuildContext context, RouteState state,
      SidebarPanelState detailBarState)? detailBarBuilder;
  final TextDirection direction;
  final Unit? sidebarMaxWidth;
  final Unit? detailBarMaxWidth;
  final Color? backgroundColor;
  final SidebarPanelController? sidebarController;
  final SidebarPanelController? detailBarController;

  const _SidebarShellLayout({
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
  State<_SidebarShellLayout> createState() => _SidebarShellLayoutState();
}

class _SidebarShellLayoutState extends State<_SidebarShellLayout> {
  SidebarPanelState _sidebarInternalState = const SidebarPanelState();
  SidebarPanelState _detailBarInternalState = const SidebarPanelState();
  // RouteState? _previousRouteState; // For route change listening if needed explicitly

  @override
  void initState() {
    super.initState();
    _sidebarInternalState =
        component.sidebarController?.state ?? _sidebarInternalState;
    _detailBarInternalState =
        component.detailBarController?.state ?? _detailBarInternalState;

    component.sidebarController?.addListener(_onSidebarControllerUpdate);
    component.detailBarController?.addListener(_onDetailBarControllerUpdate);
    // _previousRouteState = component.routeState;
  }

  @override
  void didUpdateComponent(_SidebarShellLayout oldWidget) {
    super.didUpdateComponent(oldWidget);
    if (oldWidget.sidebarController != component.sidebarController) {
      oldWidget.sidebarController?.removeListener(_onSidebarControllerUpdate);
      component.sidebarController?.addListener(_onSidebarControllerUpdate);
      _sidebarInternalState =
          component.sidebarController?.state ?? const SidebarPanelState();
    }
    if (oldWidget.detailBarController != component.detailBarController) {
      oldWidget.detailBarController
          ?.removeListener(_onDetailBarControllerUpdate);
      component.detailBarController?.addListener(_onDetailBarControllerUpdate);
      _detailBarInternalState =
          component.detailBarController?.state ?? const SidebarPanelState();
    }

    // if (component.routeState.location != _previousRouteState?.location) {
    //   print('Route changed in _SidebarShellLayout: From ${_previousRouteState?.location} to ${component.routeState.location}');
    //   _previousRouteState = component.routeState;
    // }
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

    const Unit defaultSidebarMaxWidth = Unit.pixels(240);
    const Unit defaultDetailBarMaxWidth = Unit.pixels(240);

    final Unit effectiveSidebarMaxWidth =
        component.sidebarMaxWidth ?? defaultSidebarMaxWidth;
    final Unit effectiveDetailBarMaxWidth =
        component.detailBarMaxWidth ?? defaultDetailBarMaxWidth;

    final List<Component> inFlowChildren = [];
    final List<Component> overlayChildren = [];

    if (showSidebar && component.sidebarBuilder != null) {
      final sidebarContent = component.sidebarBuilder!(
          context, component.routeState, sidebarPanelState);
      final sidebarContainer = Container(
        constraints: BoxConstraints(maxWidth: effectiveSidebarMaxWidth),
        height: (sidebarPanelState.mode == SidebarMode.overlay) ? 100.vh : null,
        child: div(
          classes: 'h-full w-full',
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
                          : null),
                  zIndex: ZIndex(10))
              : null,
        ),
      );
      if (sidebarPanelState.mode == SidebarMode.overlay) {
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
        height:
            (detailBarPanelState.mode == SidebarMode.overlay) ? 100.vh : null,
        child: div(
            classes: 'h-full w-full',
            [detailBarContent],
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
                            : null),
                    zIndex: ZIndex(10))
                : null),
      );
      if (detailBarPanelState.mode == SidebarMode.overlay) {
        overlayChildren.add(detailBarContainer);
      } else {
        inFlowChildren.add(detailBarContainer);
      }
    }

    final List<Component> finalInFlowChildren = [];
    if (component.direction == TextDirection.ltr) {
      if (showSidebar && sidebarPanelState.mode != SidebarMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.firstWhere((c) => true,
            orElse: () =>
                DomComponent(tag: 'span'))); // Placeholder if not found
      }
      finalInFlowChildren.add(mainContent);
      if (showDetailBar && detailBarPanelState.mode != SidebarMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.lastWhere((c) => true,
            orElse: () => DomComponent(tag: 'span')));
      }
    } else {
      // RTL
      if (showDetailBar && detailBarPanelState.mode != SidebarMode.overlay) {
        finalInFlowChildren.add(inFlowChildren.firstWhere((c) => true,
            orElse: () => DomComponent(tag: 'span')));
      }
      finalInFlowChildren.add(mainContent);
      if (showSidebar && sidebarPanelState.mode != SidebarMode.overlay) {
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

class SidebarShell extends ShellRoute {
  SidebarShell({
    required super.routes,
    Component Function(BuildContext context, RouteState state,
            SidebarPanelState sidebarState)?
        sidebarBuilder,
    Component Function(BuildContext context, RouteState state,
            SidebarPanelState detailBarState)?
        detailBarBuilder,
    TextDirection direction = TextDirection.ltr,
    Unit? sidebarMaxWidth,
    Unit? detailBarMaxWidth,
    Color? backgroundColor,
    SidebarPanelController? sidebarController,
    SidebarPanelController? detailBarController,
    Object?
        navigatorKey, // Retain if needed for advanced Jaspr routing scenarios
  }) : super(
          builder: (context, state, child) => _SidebarShellLayout(
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
