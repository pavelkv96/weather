import 'package:injectable/injectable.dart';
import 'package:weather/src/common/error/error.dart';
import 'package:weather/src/common/util/constants/enums.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/forecast/data/datasource/forecast_local_data_source.dart';
import 'package:weather/src/feature/forecast/data/mapper/mapper.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';
import 'package:weather/src/feature/forecast/domain/repositories/forecast_repository.dart';

@LazySingleton(as: ForecastRepository)
class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastLocalDataSource _forecastLocalDataSource;

  const ForecastRepositoryImpl({
    required ForecastLocalDataSource forecastLocalDataSource,
  }) : _forecastLocalDataSource = forecastLocalDataSource;

  @override
  Stream<Result<List<HourlyForecastDomain>>> fetchHourlyForecast({required int cityId}) async* {
    try {
      final forecast = await _forecastLocalDataSource.fetchForecastByCityId(
        cityId: cityId,
        forecast: Forecast.twelveHours,
      );
      yield* _forecastLocalDataSource
          .fetchHourlyForecast(forecastId: forecast.id)
          .map((event) => Result.success(event.toDomain()));
    } on Object catch (error, stack) {
      yield* Stream.value(Result.failure(handleError(error: error, stack: stack)));
    }
  }

  @override
  Stream<Result<List<DailyForecastDomain>>> fetchDailyForecast({required int cityId}) async* {
    try {
      final forecast = await _forecastLocalDataSource.fetchForecastByCityId(
        cityId: cityId,
        forecast: Forecast.fiveDays,
      );
      yield* _forecastLocalDataSource
          .fetchDailyForecast(forecastId: forecast.id)
          .map((event) => Result.success(event.toDomain()));
    } on Object catch (error, stack) {
      yield* Stream.value(Result.failure(handleError(error: error, stack: stack)));
    }
  }
}
