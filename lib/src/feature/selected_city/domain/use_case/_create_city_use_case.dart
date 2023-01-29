part of 'use_case.dart';

@injectable
class CreateCityUseCase implements UseCase<CreateCityInput, Future<Result<bool>>> {
  final SelectedCityRepository _selectedCityRepository;

  const CreateCityUseCase({
    required SelectedCityRepository selectedCityRepository,
  }) : _selectedCityRepository = selectedCityRepository;

  @override
  Future<Result<bool>> call({required CreateCityInput input}) {
    return _selectedCityRepository.createCity(createCityInput: input);
  }
}
