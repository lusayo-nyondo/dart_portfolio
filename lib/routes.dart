import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/components.dart';

import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/contact.dart';
import 'pages/projects.dart';

getRoutes(BuildContext context) => <RouteBase>[
      SidebarShell(
        sidebarBuilder: (context, routeState, sidebarState) => Container(
          padding: Padding.all(8.px),
          height: 100.percent,
          decoration: BoxDecoration(
            border: Border.only(
                right: BorderSide(width: 1.px, color: Colors.black)),
          ),
          child: Column(spacing: 8.px, children: [
            SidebarLink(
                path: '/', // Use NavLink for Jaspr Router v0.4+
                child: TextComponent('Home'),
                isActive: routeState.fullpath == '/'),
            SidebarLink(
                path: '/about', // Use NavLink
                child: TextComponent('About'),
                isActive: routeState.fullpath == '/about'),
            SidebarLink(
              path: '/nested', // Use NavLink
              child: TextComponent('Nested Scaffold'),
              isActive: routeState.fullpath == '/nested',
            ),
          ]),
        ),
        routes: <RouteBase>[
          Route(path: '/', name: 'home', builder: (context, state) => Home()),
          Route(
              path: '/about',
              name: 'about',
              builder: (context, state) => Center(child: About())),
          HeaderFooterShell(
            headerBuilder: (context, routeState) => Container(
                padding: Padding.all(16.px),
                child: Row(
                  spacing: 4.px,
                  children: [
                    NavLink(
                        isActive: routeState.fullpath == '/nested',
                        path: '/nested',
                        child: TextComponent('Nested Home')),
                    NavLink(
                        isActive: routeState.fullpath == '/nested/about',
                        path: '/nested/about',
                        child: TextComponent('Nested About')),
                  ],
                )),
            routes: <RouteBase>[
              Route(
                path: '/nested',
                builder: (context, state) => Home(),
              ),
              Route(
                  path: '/nested/about', builder: (context, state) => About()),
            ],
          ),
        ],
      ),
    ];
