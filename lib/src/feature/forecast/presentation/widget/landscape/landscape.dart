import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/generated/locale_keys.g.dart';
import 'package:weather/src/common/util/constants/asset.dart';
import 'package:weather/src/common/util/constants/temperature.dart';
import 'package:weather/src/common/util/extension/date_time.dart';
import 'package:weather/src/feature/forecast/presentation/bloc/daily_forecast_bloc.dart';
import 'package:weather/src/feature/forecast/presentation/bloc/hourly_forecast_bloc.dart';
import 'package:weather/src/feature/forecast/presentation/model/forecast_model.dart';
import 'package:weather/src/feature/selected_city/selected_city.dart';
import 'package:weather/src/navigation/navigation.dart';

part '_widget.dart';

class ForecastLandscape extends StatelessWidget {
  final SelectedCityPresentation city;

  const ForecastLandscape({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final city = context.watch<SelectedCityBloc>().state.whenOrNull(selected: (city) => city);
    if (city == null) return const SizedBox();

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _AppBar(city: city),
                  const Expanded(child: _TodayForecastContainer()),
                ],
              ),
            ),
            /*Expanded(
              child: BlocBuilder<DailyForecastBloc, DailyForecastState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (dailyForecast) => _DailyForecastSuccess(dailyForecast: dailyForecast),
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            )*/
            BlocBuilder<DailyForecastBloc, DailyForecastState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (dailyForecast) => _DailyForecastSuccess(dailyForecast: dailyForecast),
                  orElse: () => const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
