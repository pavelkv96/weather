part of 'use_case.dart';

@injectable
class FetchHourlyForecastByCityIdUseCase implements UseCase<CityIdInput, Stream<Result<List<HourlyForecastDomain>>>> {
  final ForecastRepository _forecastRepository;

  const FetchHourlyForecastByCityIdUseCase({
    required ForecastRepository forecastRepository,
  }) : _forecastRepository = forecastRepository;

  @override
  Stream<Result<List<HourlyForecastDomain>>> call({required CityIdInput input}) {
    return _forecastRepository.fetchHourlyForecast(cityId: input.id);
  }
}
