part of 'use_case.dart';

@injectable
class CreateAndSelectCityUseCase implements UseCase<CreateAndSelectCityInput, Future<Result<bool>>> {
  final SelectedCityRepository _selectedCityRepository;

  const CreateAndSelectCityUseCase({
    required SelectedCityRepository selectedCityRepository,
  }) : _selectedCityRepository = selectedCityRepository;

  @override
  Future<Result<bool>> call({required CreateAndSelectCityInput input}) {
    return _selectedCityRepository.createAndSelectCity(createAndSelectCityInput: input);
  }
}
