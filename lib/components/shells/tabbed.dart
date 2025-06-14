import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

class TabBarItem {
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

enum TabOrientation {
  horizontalTop,
  horizontalBottom,
  verticalLeft,
  verticalRight,
}

class _TabbedShellLayout extends StatelessComponent {
  final Component routerChild;
  final RouteState routeState;
  final List<TabBarItem> tabBarItems;
  final Component Function(
    BuildContext context,
    RouteState routeState,
    List<TabBarItem> tabBarItems,
  ) tabBarBuilder;
  final TabOrientation orientation;
  final Component Function(BuildContext context, RouteState state)?
      footerBuilder;
  final Color? backgroundColor;
  final Styles? tabBarContainerStyles;
  final Styles? contentContainerStyles;

  const _TabbedShellLayout({
    required this.routerChild,
    required this.routeState,
    required this.tabBarItems,
    required this.tabBarBuilder,
    this.orientation = TabOrientation.horizontalTop,
    this.footerBuilder,
    this.backgroundColor,
    this.tabBarContainerStyles,
    this.contentContainerStyles,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final tabBar = DomComponent(
      tag: 'nav', // Semantic tag for navigation
      styles: tabBarContainerStyles,
      child: tabBarBuilder(
        context,
        routeState,
        tabBarItems,
      ),
    );

    final content = Expanded(
      child: div(
        styles: contentContainerStyles,
        [routerChild], // This is the routed page content
      ),
    ); // Default footer

    final List<Component> children;
    Component shellLayout;

    switch (orientation) {
      case TabOrientation.horizontalTop:
        children = [
          tabBar,
          content,
          if (footerBuilder != null) footerBuilder!(context, routeState)
        ];
        shellLayout = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
        break;
      case TabOrientation.horizontalBottom:
        children = [
          content,
          tabBar,
          if (footerBuilder != null) footerBuilder!(context, routeState)
        ];
        shellLayout = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
        break;
      case TabOrientation.verticalLeft:
        shellLayout = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [tabBar, content]),
            ),
            if (footerBuilder != null) footerBuilder!(context, routeState),
          ],
        );
        break;
      case TabOrientation.verticalRight:
        shellLayout = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [content, tabBar]),
            ),
            if (footerBuilder != null) footerBuilder!(context, routeState),
          ],
        );
        break;
    }

    yield Container(
      constraints: BoxConstraints(minHeight: 100.vh, minWidth: 100.vw),
      color: backgroundColor,
      child: shellLayout,
    );
  }
}

class TabbedShell extends ShellRoute {
  TabbedShell({
    required super.routes,
    required List<TabBarItem> tabBarItems,
    required Component Function(BuildContext, RouteState, List<TabBarItem>)
        tabBarBuilder,
    TabOrientation orientation = TabOrientation.horizontalTop,
    Component Function(BuildContext context, RouteState state)? footerBuilder,
    Color? backgroundColor,
    Styles? tabBarContainerStyles,
    Styles? contentContainerStyles,
  }) : super(
          builder: (context, state, child) => _TabbedShellLayout(
            routerChild: child,
            routeState: state,
            tabBarItems: tabBarItems,
            tabBarBuilder: tabBarBuilder,
            orientation: orientation,
            footerBuilder: footerBuilder,
            backgroundColor: backgroundColor,
            tabBarContainerStyles: tabBarContainerStyles,
            contentContainerStyles: contentContainerStyles,
          ),
        );
}
