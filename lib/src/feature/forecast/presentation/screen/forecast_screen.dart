import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/common/widget/widget.dart';
import 'package:weather/src/di/injection.dart';
import 'package:weather/src/feature/forecast/presentation/bloc/daily_forecast_bloc.dart';
import 'package:weather/src/feature/forecast/presentation/bloc/hourly_forecast_bloc.dart';
import 'package:weather/src/feature/forecast/presentation/widget/widget.dart';
import 'package:weather/src/feature/selected_city/selected_city.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final city = context.watch<SelectedCityBloc>().state.whenOrNull(selected: (city) => city);
    if (city == null) return const Center();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return locator<DailyForecastBloc>()..add(DailyForecastEvent.fetchForecast(cityId: city.id));
          },
        ),
        BlocProvider(
          create: (context) {
            return locator<HourlyForecastBloc>()..add(HourlyForecastEvent.fetchForecast(cityId: city.id));
          },
        ),
      ],
      child: BlocListener<SelectedCityBloc, SelectedCityState>(
        listener: (context, state) {
          state.whenOrNull(
            selected: (city) {
              context.read<DailyForecastBloc>().add(DailyForecastEvent.fetchForecast(cityId: city.id));
              context.read<HourlyForecastBloc>().add(HourlyForecastEvent.fetchForecast(cityId: city.id));
            },
          );
        },
        child: OrientationLayout(
          portrait: ForecastPortrait(city: city),
          landscape: ForecastLandscape(city: city),
        ),
      ),
    );
  }
}
