part of 'use_case.dart';

@injectable
class SelectCityByIdUseCase implements UseCase<SelectCityByIdInput, Future<Result<bool>>> {
  final SelectedCityRepository _selectedCityRepository;

  const SelectCityByIdUseCase({
    required SelectedCityRepository selectedCityRepository,
  }) : _selectedCityRepository = selectedCityRepository;

  @override
  Future<Result<bool>> call({required SelectCityByIdInput input}) {
    return _selectedCityRepository.selectCityById(cityId: input.id);
  }
}
