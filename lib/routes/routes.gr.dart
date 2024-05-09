// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_movie_list/model/movie.dart' as _i7;
import 'package:flutter_movie_list/screens/description.dart' as _i1;
import 'package:flutter_movie_list/screens/home.dart' as _i2;
import 'package:flutter_movie_list/screens/movie_details.dart' as _i3;
import 'package:flutter_movie_list/screens/tabs.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    DescriptionRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DescriptionScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    MovieDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailsRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.MovieDetailsScreen(
          key: args.key,
          movie: args.movie,
        ),
      );
    },
    TabRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.TabScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.DescriptionScreen]
class DescriptionRoute extends _i5.PageRouteInfo<void> {
  const DescriptionRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DescriptionRoute.name,
          initialChildren: children,
        );

  static const String name = 'DescriptionRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MovieDetailsScreen]
class MovieDetailsRoute extends _i5.PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    _i6.Key? key,
    required _i7.Movie movie,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MovieDetailsRoute.name,
          args: MovieDetailsRouteArgs(
            key: key,
            movie: movie,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailsRoute';

  static const _i5.PageInfo<MovieDetailsRouteArgs> page =
      _i5.PageInfo<MovieDetailsRouteArgs>(name);
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({
    this.key,
    required this.movie,
  });

  final _i6.Key? key;

  final _i7.Movie movie;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, movie: $movie}';
  }
}

/// generated route for
/// [_i4.TabScreen]
class TabRoute extends _i5.PageRouteInfo<void> {
  const TabRoute({List<_i5.PageRouteInfo>? children})
      : super(
          TabRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
