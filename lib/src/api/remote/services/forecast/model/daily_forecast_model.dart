import 'package:json_annotation/json_annotation.dart';
import 'package:weather/src/api/remote/services/forecast/model/forecast.dart';

part 'daily_forecast_model.g.dart';

@JsonSerializable()
class DailyForecastsRemote {
  @JsonKey(name: 'DailyForecasts')
  final List<DailyForecastRemote> dailyForecasts;

  const DailyForecastsRemote({
    required this.dailyForecasts,
  });

  factory DailyForecastsRemote.fromJson(Map<String, dynamic> json) => _$DailyForecastsRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastsRemoteToJson(this);

  @override
  String toString() => 'DailyForecasts{dailyForecasts: $dailyForecasts}';
}

@JsonSerializable()
class DailyForecastRemote {
  @JsonKey(name: 'EpochDate')
  final int date;
  @JsonKey(name: 'Temperature')
  final TemperatureRemote temperature;
  @JsonKey(name: 'Day')
  final WeatherRemote day;
  @JsonKey(name: 'Night')
  final WeatherRemote night;

  const DailyForecastRemote({
    required this.date,
    required this.temperature,
    required this.day,
    required this.night,
  });

  factory DailyForecastRemote.fromJson(Map<String, dynamic> json) => _$DailyForecastRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastRemoteToJson(this);

  @override
  String toString() => 'DailyForecast{date: $date, temperature: $temperature, day: $day, night: $night}';
}

@JsonSerializable()
class TemperatureRemote {
  @JsonKey(name: 'Minimum')
  final TemperatureValueRemote minimum;
  @JsonKey(name: 'Maximum')
  final TemperatureValueRemote maximum;

  const TemperatureRemote({required this.minimum, required this.maximum});

  factory TemperatureRemote.fromJson(Map<String, dynamic> json) => _$TemperatureRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureRemoteToJson(this);

  @override
  String toString() => 'Temperature{minimum: $minimum, maximum: $maximum}';
}

@JsonSerializable()
class WeatherRemote {
  @JsonKey(name: 'Icon')
  final int icon;
  @JsonKey(name: 'IconPhrase')
  final String name;

  const WeatherRemote({required this.icon, required this.name});

  factory WeatherRemote.fromJson(Map<String, dynamic> json) => _$WeatherRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRemoteToJson(this);

  @override
  String toString() => 'Weather{icon: $icon, name: $name}';
}
