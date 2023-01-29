import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/api/remote/remote.dart';
import 'package:weather/src/common/util/network/cancel_token_callback.dart';

@module
abstract class NetworkModule {
  static const String _accuWeatherApikey = 'YOUR_KEY';
  static const String _accuWeatherBaseUrl = 'http://dataservice.accuweather.com/';

  CancelCallback cancelToken() => CancelCallback(token: CancelToken());

  @lazySingleton
  Dio defaultClient() {
    final interceptors = [
      AuthInterceptor(apikey: _accuWeatherApikey),
      ErrorInterceptor(),
    ];

    final dio = Dio();
    dio.options.baseUrl = _accuWeatherBaseUrl;
    dio.interceptors.addAll(interceptors);
    return dio;
  }

  @lazySingleton
  ForecastService forecastService(Dio dio) => ForecastService(dio);

  @lazySingleton
  LocationService locationService(Dio dio) => LocationService(dio);
}
