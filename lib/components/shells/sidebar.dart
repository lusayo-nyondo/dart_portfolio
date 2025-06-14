import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

ShellRouteBuilder _getBuilder({
  Component Function(BuildContext context, RouteState state)? headerBuilder,
  Component Function(BuildContext context, RouteState state)? footerBuilder,
}) {
  return (BuildContext context, RouteState state, Component child) {
    return Container();
  };
}

class SidebarShell extends ShellRoute {
  // headerBuilder and footerBuilder are now passed directly to _getBuilder

  SidebarShell({
    required super.routes,
    Component Function(BuildContext context, RouteState state)? headerBuilder,
    Component Function(BuildContext context, RouteState state)? footerBuilder,
  }) : super(
            builder: _getBuilder(
          headerBuilder: headerBuilder,
          footerBuilder: footerBuilder,
        ));
}
