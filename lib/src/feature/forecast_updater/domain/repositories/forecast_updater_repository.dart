abstract class ForecastUpdaterRepository {
  Future<void> forecastForCity({required int cityId});

  Future<void> forecastsForCities();
}
