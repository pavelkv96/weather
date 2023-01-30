import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/use_case/use_case.dart';
import 'package:weather/src/feature/forecast_updater/domain/repositories/forecast_updater_repository.dart';

part '_check_updates_forecast_for_city_use_case.dart';

part '_check_updates_forecasts_for_cities_use_case.dart';

class CheckUpdatesForecastForCityInput with EquatableMixin {
  final int id;

  const CheckUpdatesForecastForCityInput({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
