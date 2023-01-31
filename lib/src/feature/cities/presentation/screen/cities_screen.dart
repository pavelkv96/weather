import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/common/widget/widget.dart';
import 'package:weather/src/di/injection.dart';
import 'package:weather/src/feature/cities/presentation/bloc/cities_bloc.dart';
import 'package:weather/src/feature/cities/presentation/widget/widget.dart';
import 'package:weather/src/feature/forecast_updater/forecast_updater.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CitiesListBloc>(
      create: (context) {
        context.read<ForecastUpdaterBloc>().add(const ForecastUpdaterEvent.forecastsForCities());
        return locator<CitiesListBloc>();
      },
      child: const OrientationLayout(
        portrait: CitiesListPortrait(),
      ),
    );
  }
}
