import 'package:injectable/injectable.dart';
import 'package:weather/src/api/remote/remote.dart';

abstract class ForecastUpdaterRemoteDataSource {
  Future<DailyForecastsRemote> fetchDailyForOneDayForecast({required int city, required String language});

  Future<DailyForecastsRemote> fetchDailyForFiveDaysForecast({required int city, required String language});

  Future<List<HourlyForecastRemote>> fetchHourlyForOneHourForecast({required int city, required String language});

  Future<List<HourlyForecastRemote>> fetchHourlyForTwelveHoursForecast({required int city, required String language});
}

@LazySingleton(as: ForecastUpdaterRemoteDataSource)
class ForecastUpdaterRemoteDataSourceImpl implements ForecastUpdaterRemoteDataSource {
  final ForecastService _forecastService;

  const ForecastUpdaterRemoteDataSourceImpl({
    required ForecastService forecastService,
  }) : _forecastService = forecastService;

  @override
  Future<DailyForecastsRemote> fetchDailyForFiveDaysForecast({required int city, required String language}) {
    return _forecastService.fetchDailyForFiveDaysForecast(city: city.toString(), language: language);
  }

  @override
  Future<DailyForecastsRemote> fetchDailyForOneDayForecast({required int city, required String language}) {
    return _forecastService.fetchDailyForOneDayForecast(city: city.toString(), language: language);
  }

  @override
  Future<List<HourlyForecastRemote>> fetchHourlyForOneHourForecast({required int city, required String language}) {
    return _forecastService.fetchHourlyForOneHourForecast(city: city.toString(), language: language);
  }

  @override
  Future<List<HourlyForecastRemote>> fetchHourlyForTwelveHoursForecast({required int city, required String language}) {
    return _forecastService.fetchHourlyForTwelveHoursForecast(city: city.toString(), language: language);
  }
}
