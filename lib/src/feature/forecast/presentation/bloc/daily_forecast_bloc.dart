import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';
import 'package:weather/src/feature/forecast/domain/use_case/use_case.dart';
import 'package:weather/src/feature/forecast/presentation/model/forecast_model.dart';

part 'daily_forecast_bloc.freezed.dart';

@freezed
class DailyForecastEvent with _$DailyForecastEvent {
  const DailyForecastEvent._();

  const factory DailyForecastEvent.fetchForecast({required int cityId}) = _FetchForecastDailyForecastEvent;

  const factory DailyForecastEvent.forecastChanged({
    required Result<List<DailyForecastDomain>> result,
  }) = _ForecastChangedDailyForecastEvent;
}

@freezed
class DailyForecastState with _$DailyForecastState {
  const DailyForecastState._();

  const factory DailyForecastState.initial() = _InitialDailyForecastState;

  const factory DailyForecastState.loading() = _LoadingDailyForecastState;

  const factory DailyForecastState.success({
    required List<DailyForecastPresentation> dailyForecast,
  }) = _SuccessDailyForecastState;

  const factory DailyForecastState.empty() = _EmptyDailyForecastState;

  const factory DailyForecastState.error({required String message}) = _ErrorDailyForecastState;
}

@injectable
class DailyForecastBloc extends Bloc<DailyForecastEvent, DailyForecastState> {
  final FetchDailyForecastByCityIdUseCase _fetchDailyForecastByCityIdUseCase;

  StreamSubscription<Result<List<DailyForecastDomain>>>? _dailyForecastStreamSubscription;

  DailyForecastBloc({
    required FetchDailyForecastByCityIdUseCase fetchDailyForecastByCityIdUseCase,
  })  : _fetchDailyForecastByCityIdUseCase = fetchDailyForecastByCityIdUseCase,
        super(const DailyForecastState.initial()) {
    on<_FetchForecastDailyForecastEvent>(_handleFetchForecast);
    on<_ForecastChangedDailyForecastEvent>(_handleForecastChanged);

  }

  void _handleFetchForecast(_FetchForecastDailyForecastEvent event, Emitter<DailyForecastState> emit) {
    _dailyForecastStreamSubscription?.cancel();
    _dailyForecastStreamSubscription = null;
    emit(const DailyForecastState.loading());
    final input = CityIdInput(id: event.cityId);
    _dailyForecastStreamSubscription = _fetchDailyForecastByCityIdUseCase(input: input).listen((result) {
      add(DailyForecastEvent.forecastChanged(result: result));
    });
  }

  void _handleForecastChanged(_ForecastChangedDailyForecastEvent event, Emitter<DailyForecastState> emit) {
    final result = event.result;
    final newState = result.when(
      success: (data) {
        return data.isEmpty
            ? const DailyForecastState.empty()
            : DailyForecastState.success(dailyForecast: data.toPresentation());
      },
      failure: (error) => DailyForecastState.error(message: error.message),
    );
    return emit(newState);
  }

  @override
  Future<void> close() {
    _dailyForecastStreamSubscription?.cancel();
    _dailyForecastStreamSubscription = null;
    return super.close();
  }
}
