part of 'use_case.dart';

@injectable
class CheckUpdatesForecastsForCitiesUseCase implements VoidUseCase<Future<void>> {
  final ForecastUpdaterRepository _forecastUpdaterRepository;

  const CheckUpdatesForecastsForCitiesUseCase({
    required ForecastUpdaterRepository forecastUpdaterRepository,
  }) : _forecastUpdaterRepository = forecastUpdaterRepository;

  @override
  Future<void> call() => _forecastUpdaterRepository.forecastsForCities();
}
