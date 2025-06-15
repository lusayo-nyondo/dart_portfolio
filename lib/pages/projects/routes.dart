import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'package:dart_portfolio/cassaden_ui/cassaden_ui.dart';

import 'page.dart';

getRoutes(String baseName) {
  NavigationPanelController controller = NavigationPanelController();

  return NavigationPanelShell(
      sidebarController: controller,
      routes: <RouteBase>[
        Route(path: baseName, builder: (context, state) => Projects()),
      ],
      sidebarBuilder: (context, routeState, navigationPanelState) => Container(
            height: 100.percent,
            padding: Padding.all(2.px),
            decoration: BoxDecoration(
                border: Border.only(right: BorderSide.solid(width: 1.px))),
            child: Column(
                spacing: 8.px,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Component>[
                  FilledButton(
                    child: TextComponent('Toggle Sidenav'),
                    onPressed: () => controller.toggle(),
                  ),
                  SidebarLink(path: baseName, child: TextComponent("Index")),
                ]),
          ));
}
