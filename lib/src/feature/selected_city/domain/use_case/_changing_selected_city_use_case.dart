part of 'use_case.dart';

@injectable
class ChangingSelectCityUseCase implements VoidUseCase<Stream<Result<SelectedCityDomain?>>> {
  final SelectedCityRepository _selectedCityRepository;

  const ChangingSelectCityUseCase({
    required SelectedCityRepository selectedCityRepository,
  }) : _selectedCityRepository = selectedCityRepository;

  @override
  Stream<Result<SelectedCityDomain?>> call() {
    return _selectedCityRepository.changingSelectedCity();
  }
}
