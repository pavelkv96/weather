import 'package:injectable/injectable.dart';
import 'package:weather/src/api/remote/remote.dart';

abstract class ForecastUpdaterRemoteDataSource {
  Future<DailyForecastsRemote> fetchDailyForOneDayForecast({required int city});

  Future<DailyForecastsRemote> fetchDailyForFiveDaysForecast({required int city});

  Future<List<HourlyForecastRemote>> fetchHourlyForOneHourForecast({required int city});

  Future<List<HourlyForecastRemote>> fetchHourlyForTwelveHoursForecast({required int city});
}

@LazySingleton(as: ForecastUpdaterRemoteDataSource)
class ForecastUpdaterRemoteDataSourceImpl implements ForecastUpdaterRemoteDataSource {
  final ForecastService _forecastService;

  const ForecastUpdaterRemoteDataSourceImpl({
    required ForecastService forecastService,
  }) : _forecastService = forecastService;

  @override
  Future<DailyForecastsRemote> fetchDailyForFiveDaysForecast({required int city}) {
    return _forecastService.fetchDailyForFiveDaysForecast(city: city.toString());
  }

  @override
  Future<DailyForecastsRemote> fetchDailyForOneDayForecast({required int city}) {
    return _forecastService.fetchDailyForOneDayForecast(city: city.toString());
  }

  @override
  Future<List<HourlyForecastRemote>> fetchHourlyForOneHourForecast({required int city}) {
    return _forecastService.fetchHourlyForOneHourForecast(city: city.toString());
  }

  @override
  Future<List<HourlyForecastRemote>> fetchHourlyForTwelveHoursForecast({required int city}) {
    return _forecastService.fetchHourlyForTwelveHoursForecast(city: city.toString());
  }
}
