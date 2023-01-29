part of 'use_case.dart';

@injectable
class DeleteCityByIdUseCase implements UseCase<CityDeleteInput, Future<Result<bool>>> {
  final CitiesRepository _citiesRepository;

  const DeleteCityByIdUseCase({
    required CitiesRepository citiesRepository,
  }) : _citiesRepository = citiesRepository;

  @override
  Future<Result<bool>> call({required CityDeleteInput input}) {
    return _citiesRepository.deleteCityById(cityId: input.id);
  }
}
