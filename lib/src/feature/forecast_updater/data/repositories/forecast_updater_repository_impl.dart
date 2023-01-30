import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/api/remote/remote.dart';
import 'package:weather/src/common/error/error.dart';
import 'package:weather/src/common/util/constants/enums.dart';
import 'package:weather/src/feature/forecast_updater/data/datasource/forecast_updater_local_data_source.dart';
import 'package:weather/src/feature/forecast_updater/data/datasource/forecast_updater_remote_data_source.dart';
import 'package:weather/src/feature/forecast_updater/data/mapper/mapper.dart';
import 'package:weather/src/feature/forecast_updater/domain/repositories/forecast_updater_repository.dart';

@LazySingleton(as: ForecastUpdaterRepository)
class ForecastUpdaterRepositoryImpl implements ForecastUpdaterRepository {
  final ForecastUpdaterLocalDataSource _forecastUpdaterLocalDataSource;
  final ForecastUpdaterRemoteDataSource _forecastUpdaterRemoteDataSource;

  const ForecastUpdaterRepositoryImpl({
    required ForecastUpdaterLocalDataSource forecastUpdaterLocalDataSource,
    required ForecastUpdaterRemoteDataSource forecastUpdaterRemoteDataSource,
  })  : _forecastUpdaterLocalDataSource = forecastUpdaterLocalDataSource,
        _forecastUpdaterRemoteDataSource = forecastUpdaterRemoteDataSource;

  @override
  Future<void> forecastForCity({required int cityId}) async {
    final language = tr('ru-ru');
    await _updateDailyForecast(
      cityId: cityId,
      forecastType: Forecast.fiveDays,
      request: () => _forecastUpdaterRemoteDataSource.fetchDailyForFiveDaysForecast(city: cityId, language: language),
    );

    await _updateHourlyForecast(
      cityId: cityId,
      forecastType: Forecast.twelveHours,
      request: () {
        return _forecastUpdaterRemoteDataSource.fetchHourlyForTwelveHoursForecast(city: cityId, language: language);
      },
    );
  }

  Future<void> _updateHourlyForecast({
    required int cityId,
    required Forecast forecastType,
    required Future<List<HourlyForecastRemote>> Function() request,
  }) async {
    try {
      final forecast = await _forecastUpdaterLocalDataSource.fetchLastUpdate(cityId: cityId, forecast: forecastType);
      if (forecast.lastUpdate.add(const Duration(hours: 1)).isBefore(DateTime.now())) {
        final hourly = await request();
        await _forecastUpdaterLocalDataSource.updateHourlyForecasts(
          forecastId: forecast.id,
          hourlyForecasts: hourly.toLocal(forecast.id),
        );
      }
    } on Object catch (error, stack) {
      handleError(error: error, stack: stack);
    }
  }

  Future<void> _updateDailyForecast({
    required int cityId,
    required Forecast forecastType,
    required Future<DailyForecastsRemote> Function() request,
  }) async {
    try {
      final forecast = await _forecastUpdaterLocalDataSource.fetchLastUpdate(cityId: cityId, forecast: forecastType);
      if (forecast.lastUpdate.add(const Duration(hours: 1)).isBefore(DateTime.now())) {
        final daily = await request();
        await _forecastUpdaterLocalDataSource.updateDailyForecasts(
          forecastId: forecast.id,
          dailyForecasts: daily.dailyForecasts.toLocal(forecast.id),
        );
      }
    } on Object catch (error, stack) {
      handleError(error: error, stack: stack);
    }
  }

  @override
  Future<void> forecastsForCities() async {
    final language = tr('ru-ru');
    final cities = await _forecastUpdaterLocalDataSource.fetchAllCitiesIds();
    await Future.forEach(
      cities,
      (cityId) {
        _updateDailyForecast(
          cityId: cityId,
          forecastType: Forecast.oneDay,
          request: () => _forecastUpdaterRemoteDataSource.fetchDailyForOneDayForecast(city: cityId, language: language),
        );
        _updateHourlyForecast(
          cityId: cityId,
          forecastType: Forecast.oneHour,
          request: () {
            return _forecastUpdaterRemoteDataSource.fetchHourlyForOneHourForecast(city: cityId, language: language);
          },
        );
      },
    );
  }
}
