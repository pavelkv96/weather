import 'package:injectable/injectable.dart';
import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/common/util/constants/enums.dart';

abstract class ForecastLocalDataSource {

  Future<ForecastLocal> fetchForecastByCityId({required int cityId, required Forecast forecast});

  Stream<List<HourlyForecastLocal>> fetchHourlyForecast({required int forecastId});

  Stream<List<DailyForecastLocal>> fetchDailyForecast({required int forecastId});
}

@LazySingleton(as: ForecastLocalDataSource)
class ForecastLocalDataSourceImpl implements ForecastLocalDataSource {
  final ForecastDao _forecastDao;
  final HourlyForecastsDao _hourlyForecastsDao;
  final DailyForecastsDao _dailyForecastsDao;

  const ForecastLocalDataSourceImpl({
    required ForecastDao forecastDao,
    required HourlyForecastsDao hourlyForecastsDao,
    required DailyForecastsDao dailyForecastsDao,
  })  : _forecastDao = forecastDao,
        _hourlyForecastsDao = hourlyForecastsDao,
        _dailyForecastsDao = dailyForecastsDao;

  @override
  Future<ForecastLocal> fetchForecastByCityId({required int cityId, required Forecast forecast}) {
    return _forecastDao.fetchLastUpdate(cityId: cityId, forecast: forecast);
  }

  @override
  Stream<List<DailyForecastLocal>> fetchDailyForecast({required int forecastId}) {
    return _dailyForecastsDao.fetchDailyForecast(forecastId: forecastId);
  }

  @override
  Stream<List<HourlyForecastLocal>> fetchHourlyForecast({required int forecastId}) {
    return _hourlyForecastsDao.fetchHourlyForecast(forecastId: forecastId);
  }
}
