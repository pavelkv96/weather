import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/selected_city/domain/model/selected_city_model.dart';
import 'package:weather/src/feature/selected_city/domain/use_case/use_case.dart';
import 'package:weather/src/feature/selected_city/presentation/model/selected_city_model.dart';

part 'selected_city_bloc.freezed.dart';

@freezed
class SelectedCityEvent with _$SelectedCityEvent {
  factory SelectedCityEvent.statusChanged(SelectedCityDomain? city) = _StatusChangedSelectedCityEvent;

  const factory SelectedCityEvent.selectCity({required int id}) = _SelectCitySelectedCityEvent;

  const factory SelectedCityEvent.createAndSelectCity({
    required int id,
    required String name,
    required String area,
    required String country,
  }) = _CreateAndSelectCitySelectedCityEvent;

  const factory SelectedCityEvent.createCity({
    required int id,
    required String name,
    required String area,
    required String country,
  }) = _CreateCitySelectedCityEvent;
}

@freezed
class SelectedCityState with _$SelectedCityState {
  const SelectedCityState._();

  const factory SelectedCityState.unknown() = _UnknownSelectedCityState;

  const factory SelectedCityState.unselected() = _UnselectedCityState;

  const factory SelectedCityState.selected(SelectedCityPresentation city) = _SelectedCityState;
}

@lazySingleton
class SelectedCityBloc extends Bloc<SelectedCityEvent, SelectedCityState> {
  final ChangingSelectCityUseCase _changingSelectCityUseCase;
  final SelectCityByIdUseCase _selectCityByIdUseCase;
  final CreateAndSelectCityUseCase _createAndSelectCityUseCase;
  final CreateCityUseCase _createCityUseCase;

  late StreamSubscription<Result<SelectedCityDomain?>> _streamSubscription;

  SelectedCityBloc({
    required ChangingSelectCityUseCase changingSelectCityUseCase,
    required SelectCityByIdUseCase selectCityByIdUseCase,
    required CreateAndSelectCityUseCase createAndSelectCityUseCase,
    required CreateCityUseCase createCityUseCase,
  })  : _changingSelectCityUseCase = changingSelectCityUseCase,
        _selectCityByIdUseCase = selectCityByIdUseCase,
        _createAndSelectCityUseCase = createAndSelectCityUseCase,
        _createCityUseCase = createCityUseCase,
        super(const SelectedCityState.unknown()) {
    _streamSubscription = _changingSelectCityUseCase().listen((result) {
      result.whenOrNull(success: (selectedCity) => add(SelectedCityEvent.statusChanged(selectedCity)));
    });

    on<_StatusChangedSelectedCityEvent>(_handleStatusChanged);

    on<_CreateCitySelectedCityEvent>(_handleCreateCity);

    on<_CreateAndSelectCitySelectedCityEvent>(_handleCreateAndSelectCity);

    on<_SelectCitySelectedCityEvent>(_handleSelectCity);
  }

  Future<void> _handleStatusChanged(
    _StatusChangedSelectedCityEvent event,
    Emitter<SelectedCityState> emit,
  ) async {
    final city = event.city;
    emit(city != null ? SelectedCityState.selected(city.toPresentation()) : const SelectedCityState.unselected());
  }

  Future<void> _handleSelectCity(_SelectCitySelectedCityEvent event, Emitter<SelectedCityState> emit) async {
    await _selectCityByIdUseCase(input: SelectCityByIdInput(id: event.id));
  }

  Future<void> _handleCreateAndSelectCity(
    _CreateAndSelectCitySelectedCityEvent event,
    Emitter<SelectedCityState> emit,
  ) async {
    final input = CreateAndSelectCityInput(id: event.id, name: event.name, area: event.area, country: event.country);
    await _createAndSelectCityUseCase(input: input);
  }

  Future<void> _handleCreateCity(_CreateCitySelectedCityEvent event, Emitter<SelectedCityState> emit) async {
    final input = CreateCityInput(id: event.id, name: event.name, area: event.area, country: event.country);
    await _createCityUseCase(input: input);
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
