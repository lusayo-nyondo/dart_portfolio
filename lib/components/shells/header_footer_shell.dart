import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components.dart';

Component Function(BuildContext context, RouteState state) _getBuilder(
    BuildContext context,
    {Function(BuildContext context, RouteState state)? headerBuilder}) {
  Component builder(BuildContext context, RouteState state) {
    return Container();
  }

  return builder;
}

class HeaderFooterShell extends ShellRoute {
  final Function(BuildContext context, RouteState state)? headerBuilder;
  final Function(BuildContext context, RouteState state)? footerBuilder;

  final BuildContext context;

  HeaderFooterShell({
    required super.routes,
    required this.context,
    this.headerBuilder,
    this.footerBuilder,
  }) : super(builder: _getBuilder(context, headerBuilder: headerBuilder));
}
