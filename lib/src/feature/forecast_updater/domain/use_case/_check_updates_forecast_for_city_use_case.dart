part of 'use_case.dart';

@injectable
class CheckUpdatesForecastForCityUseCase implements UseCase<CheckUpdatesForecastForCityInput, Future<void>> {
  final ForecastUpdaterRepository _forecastUpdaterRepository;

  const CheckUpdatesForecastForCityUseCase({
    required ForecastUpdaterRepository forecastUpdaterRepository,
  }) : _forecastUpdaterRepository = forecastUpdaterRepository;

  @override
  Future<void> call({required CheckUpdatesForecastForCityInput input}) {
    return _forecastUpdaterRepository.forecastForCity(cityId: input.id);
  }
}
