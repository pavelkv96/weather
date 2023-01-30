import 'package:injectable/injectable.dart';
import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/common/util/constants/enums.dart';

abstract class ForecastUpdaterLocalDataSource {
  Future<List<int>> fetchAllCitiesIds();

  Future<ForecastLocal> fetchLastUpdate({required int cityId, required Forecast forecast});

  Future<void> updateDailyForecasts({
    required int forecastId,
    required List<DailyForecastLocal> dailyForecasts,
  });

  Future<void> updateHourlyForecasts({
    required int forecastId,
    required List<HourlyForecastLocal> hourlyForecasts,
  });
}

@LazySingleton(as: ForecastUpdaterLocalDataSource)
class ForecastUpdaterLocalDataSourceImpl implements ForecastUpdaterLocalDataSource {
  final ForecastDao _forecastDao;
  final CitiesDao _citiesDao;

  const ForecastUpdaterLocalDataSourceImpl({
    required ForecastDao forecastDao,
    required CitiesDao citiesDao,
  })  : _forecastDao = forecastDao,
        _citiesDao = citiesDao;

  @override
  Future<ForecastLocal> fetchLastUpdate({required int cityId, required Forecast forecast}) {
    return _forecastDao.fetchLastUpdate(cityId: cityId, forecast: forecast);
  }

  @override
  Future<void> updateDailyForecasts({
    required int forecastId,
    required List<DailyForecastLocal> dailyForecasts,
  }) {
    return _forecastDao.updateDailyForecasts(forecastId: forecastId, dailyForecasts: dailyForecasts);
  }

  @override
  Future<void> updateHourlyForecasts({
    required int forecastId,
    required List<HourlyForecastLocal> hourlyForecasts,
  }) {
    return _forecastDao.updateHourlyForecasts(forecastId: forecastId, hourlyForecasts: hourlyForecasts);
  }

  @override
  Future<List<int>> fetchAllCitiesIds() {
    return _citiesDao.fetchAllCitiesIds();
  }
}
