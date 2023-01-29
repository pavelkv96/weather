import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:weather/src/common/util/network/cancel_token_callback.dart';
import 'package:weather/src/feature/city_search/domain/use_case/use_case.dart';
import 'package:weather/src/feature/city_search/presentation/model/city_search_model.dart';

part 'city_search_bloc.freezed.dart';

@freezed
class CitySearchEvent with _$CitySearchEvent {
  const CitySearchEvent._();

  factory CitySearchEvent.queryChanged({
    required String query,
    required String language,
  }) = _QueryChangedCitySearchEvent;
}

@freezed
class CitySearchState with _$CitySearchState {
  @override
  abstract final String query;

  const CitySearchState._();

  const factory CitySearchState.initial({required String query}) = _InitialCitySearchState;

  const factory CitySearchState.loading({required String query}) = _LoadingCitySearchState;

  const factory CitySearchState.success({
    required String query,
    required List<CitySearchPresentation> cities,
  }) = _SuccessCitySearchState;

  const factory CitySearchState.empty({required String query}) = _EmptyCitySearchState;

  const factory CitySearchState.error({required String query, required String message}) = _ErrorCitySearchState;
}

@injectable
class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CitySearchUseCase _citySearchUseCase;
  final CancelCallback _cancel;

  CitySearchBloc({
    required CitySearchUseCase citySearchUseCase,
    required CancelCallback cancel,
  })  : _citySearchUseCase = citySearchUseCase,
        _cancel = cancel,
        super(const CitySearchState.initial(query: '')) {
    on<_QueryChangedCitySearchEvent>(
      _handleOnQueryChanged,
      transformer: (events, mapper) => events.debounce(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }

  Future<void> _handleOnQueryChanged(_QueryChangedCitySearchEvent event, Emitter<CitySearchState> emit) async {
    final query = event.query;
    if (query.isEmpty) return emit(const CitySearchState.initial(query: ''));
    if (query.length <= 2) return emit(CitySearchState.empty(query: query));
    emit(CitySearchState.loading(query: query));
    final language = event.language;
    final result = await _citySearchUseCase(input: CitySearchInput(query: query, language: language, cancel: _cancel));
    final newEvent = result.when(
      success: (data) {
        if (data.isEmpty) {
          return CitySearchState.empty(query: query);
        } else {
          return CitySearchState.success(query: query, cities: data.toPresentation());
        }
      },
      failure: (error) => CitySearchState.error(query: query, message: error.message),
    );
    return emit(newEvent);
  }

  @override
  Future<void> close() {
    _cancel.token.cancel();
    return super.close();
  }
}
