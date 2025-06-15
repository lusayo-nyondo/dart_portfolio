import 'package:jaspr_router/jaspr_router.dart';

class JasprAppRouter extends Router {
  static JasprAppRouter? _instance;

  JasprAppRouter._({required super.routes});

  factory JasprAppRouter({required Iterable<RouteBase> defaultRoutes}) {
    _instance ??= JasprAppRouter._(routes: defaultRoutes.toList());
    return _instance!;
  }

  registerRoute(RouteBase route) {
    if (!routes.contains(route)) routes.add(route);
  }

  registerRoutes(Iterable<RouteBase> routes) {
    routes.forEach(registerRoute);
  }
}

registerRoutes(Iterable<RouteBase> routes) {
  JasprAppRouter router = JasprAppRouter(defaultRoutes: []);
  routes = Set<RouteBase>.from(routes).toList();
  router.registerRoutes(routes);
}

registerRoute(RouteBase route) {
  JasprAppRouter router = JasprAppRouter(defaultRoutes: []);
  router.registerRoute(route);
}
