part of 'use_case.dart';

@injectable
class FetchDailyForecastByCityIdUseCase implements UseCase<CityIdInput, Stream<Result<List<DailyForecastDomain>>>> {
  final ForecastRepository _forecastRepository;

  const FetchDailyForecastByCityIdUseCase({
    required ForecastRepository forecastRepository,
  }) : _forecastRepository = forecastRepository;

  @override
  Stream<Result<List<DailyForecastDomain>>> call({required CityIdInput input}) {
    return _forecastRepository.fetchDailyForecast(cityId: input.id);
  }
}
