part of 'use_case.dart';

@injectable
class FetchAllCitiesUseCase implements VoidUseCase<Stream<Result<List<CityDomain>>>> {
  final CitiesRepository _citiesRepository;

  const FetchAllCitiesUseCase({
    required CitiesRepository citiesRepository,
  }) : _citiesRepository = citiesRepository;

  @override
  Stream<Result<List<CityDomain>>> call() async* {
    yield* _citiesRepository.fetchAllCities();
  }
}
