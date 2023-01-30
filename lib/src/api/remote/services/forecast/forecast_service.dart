import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather/src/api/remote/services/forecast/forecast.dart';

part 'forecast_service.g.dart';

@RestApi()
abstract class ForecastService {
  factory ForecastService(Dio dio, {String baseUrl}) = _ForecastService;

  @GET('forecasts/v1/daily/1day/{city}')
  Future<DailyForecastsRemote> fetchDailyForOneDayForecast({
    @Path('city') required String city,
    @Query('language') required String language,
    CancelToken? token,
  });

  @GET('forecasts/v1/daily/5day/{city}')
  Future<DailyForecastsRemote> fetchDailyForFiveDaysForecast({
    @Path('city') required String city,
    @Query('language') required String language,
    CancelToken? token,
  });

  @GET('forecasts/v1/hourly/1hour/{city}')
  Future<List<HourlyForecastRemote>> fetchHourlyForOneHourForecast({
    @Path('city') required String city,
    @Query('language') required String language,
    CancelToken? token,
  });

  @GET('forecasts/v1/hourly/12hour/{city}')
  Future<List<HourlyForecastRemote>> fetchHourlyForTwelveHoursForecast({
    @Path('city') required String city,
    @Query('language') required String language,
    CancelToken? token,
  });
}
