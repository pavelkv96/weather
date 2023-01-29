import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/generated/locale_keys.g.dart';
import 'package:weather/src/feature/cities/presentation/bloc/cities_bloc.dart';
import 'package:weather/src/feature/cities/presentation/model/cities_model.dart';
import 'package:weather/src/feature/selected_city/selected_city.dart';
import 'package:weather/src/navigation/navigation.dart';

part '_widget.dart';

class CitiesListPortrait extends StatelessWidget {
  const CitiesListPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.feature_cities_appbar_title),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.router.push(const CitySearchPage()),
          ),
        ],
      ),
      body: BlocBuilder<CitiesListBloc, CitiesListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _CitiesListWidgetIdle(),
            loading: () => const _CitiesListWidgetIdle(),
            empty: () => const _CitiesListWidgetEmpty(),
            success: (cities) => _CitiesListWidgetSuccess(cities: cities),
            error: (message) => _CitiesListWidgetError(message: message),
          );
        },
      ),
    );
  }
}
