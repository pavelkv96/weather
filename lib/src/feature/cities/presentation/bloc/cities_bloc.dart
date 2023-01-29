import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/generated/locale_keys.g.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/cities/domain/model/cities_model.dart';
import 'package:weather/src/feature/cities/domain/use_case/use_case.dart';
import 'package:weather/src/feature/cities/presentation/model/cities_model.dart';

part 'cities_bloc.freezed.dart';

@freezed
class CitiesListEvent with _$CitiesListEvent {
  const factory CitiesListEvent.fetchCities() = _FetchCitiesEvent;

  const factory CitiesListEvent.deleteCity({required int id}) = _DeleteCityByIdEvent;
}

@freezed
class CitiesListState with _$CitiesListState {
  const CitiesListState._();

  const factory CitiesListState.initial() = _InitialCitiesListState;

  const factory CitiesListState.loading() = _LoadingCitiesListState;

  const factory CitiesListState.empty() = _EmptyCitiesListState;

  const factory CitiesListState.success(List<CityPresentation> cities) = _SuccessCitiesListState;

  const factory CitiesListState.error(String message) = _ErrorCitiesListState;
}

@injectable
class CitiesListBloc extends Bloc<CitiesListEvent, CitiesListState> {
  final FetchAllCitiesUseCase _fetchAllCitiesUseCase;
  final DeleteCityByIdUseCase _deleteCityByIdUseCase;

  CitiesListBloc({
    required FetchAllCitiesUseCase fetchAllCitiesUseCase,
    required DeleteCityByIdUseCase deleteCityByIdUseCase,
  })  : _fetchAllCitiesUseCase = fetchAllCitiesUseCase,
        _deleteCityByIdUseCase = deleteCityByIdUseCase,
        super(const CitiesListState.initial()) {
    on<_FetchCitiesEvent>(_handleFetchCities);
    on<_DeleteCityByIdEvent>(_handleDeleteCityById);

    add(const CitiesListEvent.fetchCities());
  }

  Future<void> _handleFetchCities(_FetchCitiesEvent event, Emitter<CitiesListState> emit) async {
    emit(const CitiesListState.loading());
    return emit.forEach<Result<List<CityDomain>>>(
      _fetchAllCitiesUseCase(),
      onData: (data) => data.when(
        success: (data) {
          return data.isNotEmpty ? CitiesListState.success(data.toPresentation()) : const CitiesListState.empty();
        },
        failure: (_) => const CitiesListState.error(LocaleKeys.core_failure_unknown),
      ),
      onError: (_, __) => const CitiesListState.error(LocaleKeys.core_failure_unknown),
    );
  }

  Future<void> _handleDeleteCityById(_DeleteCityByIdEvent event, Emitter<CitiesListState> emit) async {
    await _deleteCityByIdUseCase(input: CityDeleteInput(id: event.id));
  }
}
