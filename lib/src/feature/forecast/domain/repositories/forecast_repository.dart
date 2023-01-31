import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';

abstract class ForecastRepository {

  Stream<Result<List<HourlyForecastDomain>>> fetchHourlyForecast({required int cityId});

  Stream<Result<List<DailyForecastDomain>>> fetchDailyForecast({required int cityId});
}
