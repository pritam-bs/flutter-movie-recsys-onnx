import 'package:auto_route/auto_route.dart';
import 'package:flutter_movie_list/routes/routes.gr.dart';
import 'package:flutter_movie_list/screens/movie_details.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: TabRoute.page,
      path: '/',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home', maintainState: false),
        AutoRoute(page: DescriptionRoute.page, path: 'description'),
      ],
    ),
    AutoRoute(
      page: MovieDetailsRoute.page,
      path: '/movie-details',
    ),
  ];
}
