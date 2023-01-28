import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationRemote {
  @JsonKey(name: 'Key')
  final String key;
  @JsonKey(name: 'LocalizedName')
  final String name;

  @JsonKey(name: 'Country')
  final CountryRemote country;

  @JsonKey(name: 'AdministrativeArea')
  final AdministrativeAreaRemote area;

  const LocationRemote({
    required this.key,
    required this.name,
    required this.country,
    required this.area,
  });

  factory LocationRemote.fromJson(Map<String, dynamic> json) => _$LocationRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$LocationRemoteToJson(this);

  @override
  String toString() => 'Location{key: $key, name: $name, country: $country, area: $area}';
}

@JsonSerializable()
class CountryRemote {
  @JsonKey(name: 'LocalizedName')
  final String name;

  const CountryRemote({required this.name});

  factory CountryRemote.fromJson(Map<String, dynamic> json) => _$CountryRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$CountryRemoteToJson(this);

  @override
  String toString() => 'Country{name: $name}';
}

@JsonSerializable()
class AdministrativeAreaRemote {
  @JsonKey(name: 'LocalizedName')
  final String name;

  const AdministrativeAreaRemote({required this.name});

  factory AdministrativeAreaRemote.fromJson(Map<String, dynamic> json) => _$AdministrativeAreaRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$AdministrativeAreaRemoteToJson(this);

  @override
  String toString() => 'AdministrativeArea{name: $name}';
}
