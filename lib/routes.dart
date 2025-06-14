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
        headerBuilder: (context, state) => Container(
            padding: Padding.all(8.px),
            decoration: BoxDecoration(
                boxShadow: BoxShadow(
              offsetX: Unit.zero,
              offsetY: 0.5.px,
              blur: 2.px,
              spread: 1.px,
            )),
            child: Row(spacing: 4.px, children: <Component>[
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
                  path: '/',
                  child: TextComponent('Resume'),
                  isActive: state.fullpath == '/resume'),
              NavLink(
                  path: '/',
                  child: TextComponent('Contact'),
                  isActive: state.fullpath == '/contact'),
            ])),
      ),
    ];
