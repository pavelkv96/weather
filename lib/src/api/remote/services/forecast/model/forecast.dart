import 'package:json_annotation/json_annotation.dart';

export 'daily_forecast_model.dart';
export 'hourly_forecast_model.dart';

part 'forecast.g.dart';

@JsonSerializable()
class TemperatureValueRemote {
  @JsonKey(name: 'Value')
  final double value;

  const TemperatureValueRemote({required this.value});

  factory TemperatureValueRemote.fromJson(Map<String, dynamic> json) => _$TemperatureValueRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureValueRemoteToJson(this);

  @override
  String toString() => 'TemperatureValue{value: $value}';
}
