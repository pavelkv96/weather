import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/generated/locale_keys.g.dart';
import 'package:weather/src/feature/city_search/presentation/bloc/city_search_bloc.dart';
import 'package:weather/src/feature/city_search/presentation/model/city_search_model.dart';
import 'package:weather/src/feature/selected_city/selected_city.dart';

part '_widget.dart';

class CitySearchPortrait extends StatelessWidget {
  const CitySearchPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarSearchForm(
            onChanged: (value) {
              final event = CitySearchEvent.queryChanged(query: value, language: tr(LocaleKeys.core_locale_request));
              context.read<CitySearchBloc>().add(event);
            },
          ),
        ),
        body: BlocBuilder<CitySearchBloc, CitySearchState>(
          builder: (context, state) {
            return state.when(
              success: (_, cities) => _CitySearchWidgetSuccess(cities: cities),
              initial: (_) => const _CitySearchWidgetInitial(),
              loading: (_) => const _CitySearchWidgetLoading(),
              empty: (_) => const _CitySearchWidgetEmpty(),
              error: (query, message) {
                return _CitySearchWidgetError(
                  message: message,
                  onRetryTap: () {
                    final event = CitySearchEvent.queryChanged(
                      query: query,
                      language: tr(LocaleKeys.core_locale_request),
                    );
                    context.read<CitySearchBloc>().add(event);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
