import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/api/remote/remote.dart';
import 'package:weather/src/common/util/extension/date_time.dart';

extension ListDailyForecastsRemote on List<DailyForecastRemote> {
  List<DailyForecastLocal> toLocal(int forecastId) {
    return map(
      (day) {
        return DailyForecastLocal(
          forecastId: forecastId,
          day: DateTime.fromMillisecondsSinceEpoch(day.date * 1000).today,
          temperatureMax: day.temperature.maximum.value,
          temperatureMin: day.temperature.minimum.value,
          dayWeatherType: day.day.icon,
          nightWeatherType: day.night.icon,
        );
      },
    ).toList();
  }
}

extension ListHourlyForecastsRemote on List<HourlyForecastRemote> {
  List<HourlyForecastLocal> toLocal(int forecastId) {
    return map(
      (hour) {
        return HourlyForecastLocal(
          forecastId: forecastId,
          date: DateTime.fromMillisecondsSinceEpoch(hour.date * 1000),
          weatherType: hour.icon,
          temperature: hour.temperature.value,
        );
      },
    ).toList();
  }
}
