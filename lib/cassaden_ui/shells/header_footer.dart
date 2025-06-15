import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/components.dart';

/// Represents the state of the header.
class HeaderState {
  final bool isVisible;

  const HeaderState({this.isVisible = true});

  HeaderState copyWith({bool? isVisible}) {
    return HeaderState(isVisible: isVisible ?? this.isVisible);
  }
}

/// Controller to manage the state of the header.
class HeaderController {
  HeaderState _state;
  void Function()? _listener;

  HeaderController({HeaderState initialState = const HeaderState()})
      : _state = initialState;

  HeaderState get state => _state;
  bool get isVisible => _state.isVisible;

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

  void updateState(HeaderState newState) {
    if (_state.isVisible != newState.isVisible) {
      _state = newState;
      _notifyListeners();
    }
  }

  void addListener(void Function() listener) => _listener = listener;
  void removeListener(void Function() listener) {
    if (_listener == listener) _listener = null;
  }

  void _notifyListeners() => _listener?.call();
}

/// Represents the state of the footer.
class FooterState {
  final bool isVisible;

  const FooterState({this.isVisible = true});

  FooterState copyWith({bool? isVisible}) {
    return FooterState(isVisible: isVisible ?? this.isVisible);
  }
}

/// Controller to manage the state of the footer.
class FooterController {
  FooterState _state;
  void Function()? _listener;

  FooterController({FooterState initialState = const FooterState()})
      : _state = initialState;

  FooterState get state => _state;
  bool get isVisible => _state.isVisible;

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

  void updateState(FooterState newState) {
    if (_state.isVisible != newState.isVisible) {
      _state = newState;
      _notifyListeners();
    }
  }

  void addListener(void Function() listener) => _listener = listener;
  void removeListener(void Function() listener) {
    if (_listener == listener) _listener = null;
  }

  void _notifyListeners() => _listener?.call();
}

class _HeaderFooterShellLayout extends StatefulComponent {
  final Component routerChild;
  final RouteState routeState;
  final Component Function(BuildContext context, RouteState state)?
      headerBuilder;
  final Component Function(BuildContext context, RouteState state)?
      footerBuilder;
  final HeaderController? headerController;
  final FooterController? footerController;

  const _HeaderFooterShellLayout({
    required this.routerChild,
    required this.routeState,
    this.headerBuilder,
    this.footerBuilder,
    this.headerController,
    this.footerController,
  });

  @override
  State<_HeaderFooterShellLayout> createState() =>
      _HeaderFooterShellLayoutState();
}

class _HeaderFooterShellLayoutState extends State<_HeaderFooterShellLayout> {
  HeaderState _headerInternalState = const HeaderState();
  FooterState _footerInternalState = const FooterState();

  @override
  void initState() {
    super.initState();
    _headerInternalState =
        component.headerController?.state ?? _headerInternalState;
    _footerInternalState =
        component.footerController?.state ?? _footerInternalState;

    component.headerController?.addListener(_onHeaderControllerUpdate);
    component.footerController?.addListener(_onFooterControllerUpdate);
  }

  @override
  void didUpdateComponent(_HeaderFooterShellLayout oldWidget) {
    super.didUpdateComponent(oldWidget);
    if (oldWidget.headerController != component.headerController) {
      oldWidget.headerController?.removeListener(_onHeaderControllerUpdate);
      component.headerController?.addListener(_onHeaderControllerUpdate);
      _headerInternalState =
          component.headerController?.state ?? const HeaderState();
    }
    if (oldWidget.footerController != component.footerController) {
      oldWidget.footerController?.removeListener(_onFooterControllerUpdate);
      component.footerController?.addListener(_onFooterControllerUpdate);
      _footerInternalState =
          component.footerController?.state ?? const FooterState();
    }
  }

  @override
  void dispose() {
    component.headerController?.removeListener(_onHeaderControllerUpdate);
    component.footerController?.removeListener(_onFooterControllerUpdate);
    super.dispose();
  }

  void _onHeaderControllerUpdate() {
    setState(() {
      _headerInternalState = component.headerController!.state;
    });
  }

  void _onFooterControllerUpdate() {
    setState(() {
      _footerInternalState = component.footerController!.state;
    });
  }

  HeaderState get _effectiveHeaderState =>
      component.headerController?.state ?? _headerInternalState;
  FooterState get _effectiveFooterState =>
      component.footerController?.state ?? _footerInternalState;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final bool showHeader =
        _effectiveHeaderState.isVisible && component.headerBuilder != null;
    final bool showFooter = _effectiveFooterState.isVisible;

    yield Column(children: [
      if (showHeader)
        Container(
          // Consider making height and classes configurable
          height: 60.px,
          width: 100.percent,
          alignment: Alignment.centerLeft,
          child: DomComponent(
            tag: 'header',
            classes: 'w-full h-full',
            children: [
              component.headerBuilder!(context, component.routeState),
            ],
          ),
        ),
      Expanded(
        child: component.routerChild,
      ),
      if (showFooter && component.footerBuilder != null)
        component.footerBuilder!(
            context, component.routeState), // Default footer
    ]);
  }
}

class HeaderFooterShell extends ShellRoute {
  HeaderFooterShell({
    required super.routes,
    Component Function(BuildContext context, RouteState state)? headerBuilder,
    Component Function(BuildContext context, RouteState state)? footerBuilder,
    HeaderController? headerController,
    FooterController? footerController,
  }) : super(
          builder: (context, state, child) => _HeaderFooterShellLayout(
            routerChild: child,
            routeState: state,
            headerBuilder: headerBuilder,
            footerBuilder: footerBuilder,
            headerController: headerController,
            footerController: footerController,
          ),
        );
}
