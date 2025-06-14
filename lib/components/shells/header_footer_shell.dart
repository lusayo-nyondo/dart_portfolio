import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

ShellRouteBuilder _getBuilder(BuildContext context,
    {Function(BuildContext context, RouteState state)? headerBuilder}) {
  Component builder(context, state, child) => Container();
  return builder;
}

class HeaderFooterShell extends ShellRoute {
  final Function(BuildContext context, RouteState state)? headerBuilder;
  final Function(BuildContext context, RouteState state)? footerBuilder;

  final BuildContext context;

  final String basename;

  HeaderFooterShell({
    required this.context,
    required super.routes,
    required this.basename,
    this.headerBuilder,
    this.footerBuilder,
  }) : super(builder: _getBuilder(context, headerBuilder: headerBuilder));
}
