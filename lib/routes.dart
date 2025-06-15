import 'package:jaspr_router/jaspr_router.dart';

import 'cassaden_ui/cassaden_ui.dart';

import 'pages/home.dart';
import 'pages/projects/projects.dart' as projects;
import 'pages/resume.dart';
import 'pages/contact.dart';

getRoutes() => <RouteBase>[
      HeaderFooterShell(
          routes: <RouteBase>[
            Route(
              path: '/',
              builder: (context, state) => Home(),
            ),
            projects.getRoutes('/projects'),
            Route(path: '/resume', builder: (context, state) => Resume()),
            Route(path: '/contact', builder: (context, state) => Contact()),
          ],
          headerBuilder: (context, state) => DefaultNavbar(
                actions: <DefaultNavbarLink>[
                  DefaultNavbarLink(
                    path: '/',
                    child: TextComponent('Home'),
                    isActive: state.fullpath == '/',
                  ),
                  DefaultNavbarLink(
                      path: '/projects',
                      child: TextComponent('Projects'),
                      isActive: state.fullpath == '/projects'),
                  DefaultNavbarLink(
                      path: '/resume',
                      child: TextComponent('Resume'),
                      isActive: state.fullpath == '/resume'),
                  DefaultNavbarLink(
                      path: '/contact',
                      child: TextComponent('Contact'),
                      isActive: state.fullpath == '/contact'),
                ],
              )),
    ];
