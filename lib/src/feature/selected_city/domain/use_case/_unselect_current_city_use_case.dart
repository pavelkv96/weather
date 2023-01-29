part of 'use_case.dart';

// @injectable
class UnselectCurrentCityUseCase implements VoidUseCase<Future<Result<bool>>> {
  final SelectedCityRepository _selectedCityRepository;

  const UnselectCurrentCityUseCase({
    required SelectedCityRepository selectedCityRepository,
  }) : _selectedCityRepository = selectedCityRepository;

  @override
  Future<Result<bool>> call() {
    return _selectedCityRepository.unselectCity();
  }
}
