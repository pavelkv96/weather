import 'package:equatable/equatable.dart';
import 'package:weather/src/common/util/constants/enums.dart';

class HourlyForecastDomain with EquatableMixin {
  final int forecastId;
  final DateTime date;
  final WeatherType weatherType;
  final double? temperature;

  const HourlyForecastDomain({
    required this.forecastId,
    required this.date,
    required this.weatherType,
    required this.temperature,
  });

  @override
  List<Object?> get props => [forecastId, date, weatherType, temperature];
}

class DailyForecastDomain with EquatableMixin {
  final int forecastId;
  final DateTime day;
  final WeatherType dayWeatherType;
  final WeatherType nightWeatherType;
  final double? maxTemperature;
  final double? minTemperature;

  const DailyForecastDomain({
    required this.forecastId,
    required this.day,
    required this.dayWeatherType,
    required this.nightWeatherType,
    required this.maxTemperature,
    required this.minTemperature,
  });

  @override
  List<Object?> get props => [forecastId, day, dayWeatherType, nightWeatherType, maxTemperature, minTemperature];
}
