import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/api/remote/remote.dart';
import 'package:weather/src/common/util/constants/enums.dart';
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
          dayWeatherType: WeatherType.values.firstWhere(
            (weather) => weather.type == day.day.icon,
            orElse: () => WeatherType.unknown,
          ),
          nightWeatherType: WeatherType.values.firstWhere(
            (weather) => weather.type == day.night.icon,
            orElse: () => WeatherType.unknown,
          ),
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
          weatherType: WeatherType.values.firstWhere(
            (weather) => weather.type == hour.icon,
            orElse: () => WeatherType.unknown,
          ),
          temperature: hour.temperature.value,
        );
      },
    ).toList();
  }
}
