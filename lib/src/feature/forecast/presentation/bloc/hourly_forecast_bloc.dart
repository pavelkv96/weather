import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';
import 'package:weather/src/feature/forecast/domain/use_case/use_case.dart';
import 'package:weather/src/feature/forecast/presentation/model/forecast_model.dart';

part 'hourly_forecast_bloc.freezed.dart';

@freezed
class HourlyForecastEvent with _$HourlyForecastEvent {
  const HourlyForecastEvent._();

  const factory HourlyForecastEvent.fetchForecast({required int cityId}) = _FetchForecastHourlyForecastEvent;

  const factory HourlyForecastEvent.forecastChanged({
    required Result<List<HourlyForecastDomain>> result,
  }) = _ForecastChangedHourlyForecastEvent;
}

@freezed
class HourlyForecastState with _$HourlyForecastState {
  const HourlyForecastState._();

  const factory HourlyForecastState.initial() = _InitialHourlyForecastState;

  const factory HourlyForecastState.loading() = _LoadingHourlyForecastState;

  const factory HourlyForecastState.success({
    required List<HourlyForecastPresentation> hourlyForecast,
  }) = _SuccessHourlyForecastState;

  const factory HourlyForecastState.empty() = _EmptyHourlyForecastState;

  const factory HourlyForecastState.error({required String message}) = _ErrorHourlyForecastState;
}

@injectable
class HourlyForecastBloc extends Bloc<HourlyForecastEvent, HourlyForecastState> {
  final FetchHourlyForecastByCityIdUseCase _fetchHourlyForecastByCityIdUseCase;

  StreamSubscription<Result<List<HourlyForecastDomain>>>? _hourlyForecastStreamSubscription;

  HourlyForecastBloc({
    required FetchHourlyForecastByCityIdUseCase fetchHourlyForecastByCityIdUseCase,
  })  : _fetchHourlyForecastByCityIdUseCase = fetchHourlyForecastByCityIdUseCase,
        super(const HourlyForecastState.initial()) {
    on<_FetchForecastHourlyForecastEvent>(_handleFetchForecast);
    on<_ForecastChangedHourlyForecastEvent>(_handleForecastChanged);
  }

  void _handleFetchForecast(_FetchForecastHourlyForecastEvent event, Emitter<HourlyForecastState> emit) {
    _hourlyForecastStreamSubscription?.cancel();
    _hourlyForecastStreamSubscription = null;
    emit(const HourlyForecastState.loading());
    final input = CityIdInput(id: event.cityId);
    _hourlyForecastStreamSubscription = _fetchHourlyForecastByCityIdUseCase(input: input).listen((result) {
      add(HourlyForecastEvent.forecastChanged(result: result));
    });
  }

  void _handleForecastChanged(_ForecastChangedHourlyForecastEvent event, Emitter<HourlyForecastState> emit) {
    final result = event.result;
    final newState = result.when(
      success: (data) {
        return data.isEmpty
            ? const HourlyForecastState.empty()
            : HourlyForecastState.success(hourlyForecast: data.toPresentation());
      },
      failure: (error) => HourlyForecastState.error(message: error.message),
    );
    return emit(newState);
  }

  @override
  Future<void> close() {
    _hourlyForecastStreamSubscription?.cancel();
    _hourlyForecastStreamSubscription = null;
    return super.close();
  }
}
