import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

ShellRouteBuilder _getBuilder({
  Component Function(BuildContext context, RouteState state)? headerBuilder,
  Component Function(BuildContext context, RouteState state)? footerBuilder,
}) {
  return (BuildContext context, RouteState state, Component child) {
    return Column(children: [
      if (headerBuilder != null)
        Container(
          // Consider making height and classes configurable
          height: 60.px,
          width: 100.percent,
          alignment: Alignment.centerLeft,
          child: DomComponent(
            tag: 'header',
            classes: 'w-full h-full',
            children: [
              headerBuilder(context, state),
            ],
          ),
        ),
      Expanded(
        child: child,
      ),
      if (footerBuilder != null)
        footerBuilder(context, state), // Default footer
    ]);
  };
}

class HeaderFooterShell extends ShellRoute {
  // headerBuilder and footerBuilder are now passed directly to _getBuilder

  HeaderFooterShell({
    required super.routes,
    Component Function(BuildContext context, RouteState state)? headerBuilder,
    Component Function(BuildContext context, RouteState state)? footerBuilder,
  }) : super(
            builder: _getBuilder(
          headerBuilder: headerBuilder,
          footerBuilder: footerBuilder,
        ));
}
