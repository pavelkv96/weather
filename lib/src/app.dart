import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/generated/locale_keys.g.dart';
import 'package:weather/src/di/injection.dart';
import 'package:weather/src/feature/selected_city/selected_city.dart';
import 'package:weather/src/navigation/navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      fallbackLocale: const Locale('en'),
      useFallbackTranslations: true,
      path: 'resources/langs',
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectedCityBloc>(create: (context) => locator<SelectedCityBloc>()),
        BlocProvider<NavigationBloc>(create: (context) => locator<NavigationBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SelectedCityBloc, SelectedCityState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              final event = state.when(
                unknown: () => const NavigationEvent.splash(),
                unselected: () => const NavigationEvent.cities(),
                selected: (city) {
                  // todo check updates forecast for current city
                  return const NavigationEvent.forecast();
                },
              );
              context.read<NavigationBloc>().add(event);
            },
          ),
        ],
        child: ChangeNotifierProvider<AppRouter>(
          create: (context) => locator<AppRouter>(),
          child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              final appRouter = context.read<AppRouter>();
              return MaterialApp.router(
                routerDelegate: AutoRouterDelegate.declarative(
                  appRouter,
                  navRestorationScopeId: 'root_auto_router',
                  routes: (_) => state.pages,
                ),
                routeInformationParser: appRouter.defaultRouteParser(includePrefixMatches: true),
                restorationScopeId: 'root_router',
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) => tr(LocaleKeys.core_application_title),
                theme: ThemeData(primarySwatch: Colors.blue),
              );
            },
          ),
        ),
      ),
    );
  }
}
