part of 'use_case.dart';

@injectable
class CitySearchUseCase implements UseCase<CitySearchInput, Future<Result<List<CitySearchDomain>>>> {
  final CitySearchRepository _citySearchRepository;

  const CitySearchUseCase({
    required CitySearchRepository citySearchRepository,
  }) : _citySearchRepository = citySearchRepository;

  @override
  Future<Result<List<CitySearchDomain>>> call({required CitySearchInput input}) {
    return _citySearchRepository.fetchAutocompleteListCities(
      query: input.query,
      language: input.language,
      callback: input.cancel,
    );
  }
}
