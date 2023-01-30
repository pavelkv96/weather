import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/feature/forecast_updater/domain/use_case/use_case.dart';

part 'forecast_updater_bloc.freezed.dart';

@freezed
class ForecastUpdaterEvent {
  const ForecastUpdaterEvent._();

  const factory ForecastUpdaterEvent.forecastsForCities() = _ForecastsForCitiesEvent;

  const factory ForecastUpdaterEvent.forecastForCity({required int cityId}) = _ForecastForCityEvent;
}

class ForecastUpdaterState {
  const ForecastUpdaterState._();
}

@injectable
class ForecastUpdaterBloc extends Bloc<ForecastUpdaterEvent, ForecastUpdaterState> {
  final CheckUpdatesForecastsForCitiesUseCase _checkUpdatesForecastsForCitiesUseCase;
  final CheckUpdatesForecastForCityUseCase _checkUpdatesForecastForCityUseCase;

  ForecastUpdaterBloc({
    required CheckUpdatesForecastsForCitiesUseCase checkUpdatesForecastsForCitiesUseCase,
    required CheckUpdatesForecastForCityUseCase checkUpdatesForecastForCityUseCase,
  })  : _checkUpdatesForecastsForCitiesUseCase = checkUpdatesForecastsForCitiesUseCase,
        _checkUpdatesForecastForCityUseCase = checkUpdatesForecastForCityUseCase,
        super(const ForecastUpdaterState._()) {
    on<_ForecastsForCitiesEvent>(_handleForecastsForCities);
    on<_ForecastForCityEvent>(_handleForecastForCity);
  }

  Future<void> _handleForecastsForCities(_ForecastsForCitiesEvent event, Emitter<ForecastUpdaterState> emit) {
    return _checkUpdatesForecastsForCitiesUseCase();
  }

  Future<void> _handleForecastForCity(_ForecastForCityEvent event, Emitter<ForecastUpdaterState> emit) {
    return _checkUpdatesForecastForCityUseCase(input: CheckUpdatesForecastForCityInput(id: event.cityId));
  }
}
