import 'package:json_annotation/json_annotation.dart';
import 'package:weather/src/api/remote/services/forecast/model/forecast.dart';

part 'hourly_forecast_model.g.dart';

@JsonSerializable()
class HourlyForecastRemote {
  @JsonKey(name: 'EpochDateTime')
  final int date;
  @JsonKey(name: 'WeatherIcon')
  final int icon;
  @JsonKey(name: 'IconPhrase')
  final String iconDescription;
  @JsonKey(name: 'Temperature')
  final TemperatureValueRemote temperature;

  const HourlyForecastRemote({
    required this.date,
    required this.icon,
    required this.iconDescription,
    required this.temperature,
  });

  factory HourlyForecastRemote.fromJson(Map<String, dynamic> json) => _$HourlyForecastRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyForecastRemoteToJson(this);

  @override
  String toString() {
    return 'HourlyForecast{date: $date, icon: $icon, iconDescription: $iconDescription, temperature: $temperature}';
  }
}
