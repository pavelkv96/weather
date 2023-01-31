import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
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

class ForecastPortrait extends StatelessWidget {
  final SelectedCityPresentation city;

  const ForecastPortrait({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.router.push(const CitiesPage()),
        ),
        centerTitle: true,
        title: Text(city.name),
      ),
      body: ListView(
        children: [
          BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (hourlyForecast) => _TodayForecast(hour: hourlyForecast.first),
                orElse: () => const _TodayForecast(),
              );
            },
          ),
          BlocBuilder<DailyForecastBloc, DailyForecastState>(
            builder: (context, state) {
              l.e('STATE $state');
              return state.maybeWhen(
                success: (dailyForecast) => _DailyForecastSuccess(dailyForecast: dailyForecast),
                orElse: () => const SizedBox(),
              );
            },
          ),
          BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
            builder: (context, state) {
              l.e('STATE $state');
              return state.maybeWhen(
                success: (hourlyForecast) => _HourlyForecastSuccess(hourlyForecast: hourlyForecast),
                orElse: () => const SizedBox(),
              );
            },
          ),
          const _WeatherDataProviderWidget(),
        ],
      ),
    );
  }
}
