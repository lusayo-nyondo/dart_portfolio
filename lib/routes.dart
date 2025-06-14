import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/components.dart';

import 'pages/home.dart';
import 'pages/projects.dart';
import 'pages/resume.dart';
import 'pages/contact.dart';

getRoutes(BuildContext context) => <RouteBase>[
      HeaderFooterShell(
          routes: <RouteBase>[
            Route(
              path: '/',
              builder: (context, state) => Home(),
            ),
            Route(path: '/projects', builder: (context, state) => Projects()),
            Route(path: '/resume', builder: (context, state) => Resume()),
            Route(path: '/contact', builder: (context, state) => Contact()),
          ],
          headerBuilder: (context, state) => Navbar(
                actions: <NavLink>[
                  NavLink(
                    path: '/',
                    child: TextComponent('Home'),
                    isActive: state.fullpath == '/',
                  ),
                  NavLink(
                      path: '/projects',
                      child: TextComponent('Projects'),
                      isActive: state.fullpath == '/projects'),
                  NavLink(
                      path: '/resume',
                      child: TextComponent('Resume'),
                      isActive: state.fullpath == '/resume'),
                  NavLink(
                      path: '/contact',
                      child: TextComponent('Contact'),
                      isActive: state.fullpath == '/contact'),
                ],
              )),
    ];
