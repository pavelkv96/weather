import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/feature/cities/cities.dart';
import 'package:weather/src/feature/city_search/city_search.dart';
import 'package:weather/src/feature/forecast/forecast.dart';
import 'package:weather/src/feature/splash/splash.dart';
import 'package:weather/src/navigation/constant/constant.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Page',
  routes: <AutoRoute>[
    AutoRoute<void>(
      path: splashNamePath,
      page: SplashScreen,
    ),
    AutoRoute<void>(
      path: '/',
      page: EmptyRouterPage,
      name: 'ConfigurationCitiesPage',
      children: [
        AutoRoute<void>(path: citiesNamePath, page: CitiesScreen, initial: true),
        AutoRoute<void>(path: citySearchNamePath, page: CitySearchScreen),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute<void>(
      path: forecastNamePath,
      name: 'HomePage',
      page: EmptyRouterPage,
      initial: true,
      children: [
        AutoRoute<void>(path: '', page: ForecastScreen),
        AutoRoute<void>(path: citiesNamePath, page: CitiesScreen),
        AutoRoute<void>(path: citySearchNamePath, page: CitySearchScreen),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}
