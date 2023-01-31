import 'package:equatable/equatable.dart';
import 'package:weather/src/common/util/constants/enums.dart';
import 'package:weather/src/common/util/constants/temperature.dart';
import 'package:weather/src/common/util/extension/double.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';

class HourlyForecastPresentation with EquatableMixin {
  final int forecastId;
  final DateTime date;
  final WeatherType weatherType;
  final double? _temperature;

  const HourlyForecastPresentation({
    required this.forecastId,
    required this.date,
    required this.weatherType,
    required double? temperature,
  }) : _temperature = temperature;

  String temperature({Temperature temp = Temperature.celsius}) {
    final current = _temperature?.toTemperature(temp: temp);
    return current != null ? '${current.round()}°' : '--';
  }


  @override
  List<Object?> get props => [forecastId, date, weatherType, _temperature];
}

class DailyForecastPresentation with EquatableMixin {
  final int forecastId;
  final DateTime date;
  final WeatherType dayWeatherType;
  final WeatherType nightWeatherType;
  final double? _maxTemperature;
  final double? _minTemperature;

  const DailyForecastPresentation({
    required this.forecastId,
    required this.date,
    required this.dayWeatherType,
    required this.nightWeatherType,
    required double? maxTemperature,
    required double? minTemperature,
  })  : _maxTemperature = maxTemperature,
        _minTemperature = minTemperature;

  String todayTemperature({Temperature temp = Temperature.celsius}) {
    final max = _maxTemperature?.toTemperature(temp: temp);
    final min = _minTemperature?.toTemperature(temp: temp);
    return '${max != null ? '${max.round()}°' : '--'} / ${min != null ? '${min.round()}°' : '--'}';
  }

  @override
  List<Object?> get props => [forecastId, date, dayWeatherType, nightWeatherType, _maxTemperature, _minTemperature];
}

extension ListHourlyForecastsDomain on List<HourlyForecastDomain> {
  List<HourlyForecastPresentation> toPresentation() {
    return map((hour) {
      return HourlyForecastPresentation(
        forecastId: hour.forecastId,
        date: hour.date,
        weatherType: hour.weatherType,
        temperature: hour.temperature,
      );
    }).toList();
  }
}

extension ListDailyForecastsDomain on List<DailyForecastDomain> {
  List<DailyForecastPresentation> toPresentation() {
    return map((day) {
      return DailyForecastPresentation(
        forecastId: day.forecastId,
        date: day.day,
        dayWeatherType: day.dayWeatherType,
        nightWeatherType: day.nightWeatherType,
        maxTemperature: day.maxTemperature,
        minTemperature: day.minTemperature,
      );
    }).toList();
  }
}
