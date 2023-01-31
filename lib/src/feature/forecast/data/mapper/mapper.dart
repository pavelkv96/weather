import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';

extension ListHourlyForecastsLocal on List<HourlyForecastLocal> {
  List<HourlyForecastDomain> toDomain() {
    return map(
      (hour) {
        return HourlyForecastDomain(
          forecastId: hour.forecastId,
          date: hour.date,
          weatherType: hour.weatherType,
          temperature: hour.temperature,
        );
      },
    ).toList();
  }
}

extension ListDailyForecastsLocal on List<DailyForecastLocal> {
  List<DailyForecastDomain> toDomain() {
    return map(
      (day) {
        return DailyForecastDomain(
          forecastId: day.forecastId,
          day: day.day,
          dayWeatherType: day.dayWeatherType,
          nightWeatherType: day.nightWeatherType,
          maxTemperature: day.temperatureMax,
          minTemperature: day.temperatureMin,
        );
      },
    ).toList();
  }
}
