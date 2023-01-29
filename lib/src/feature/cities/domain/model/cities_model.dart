import 'package:equatable/equatable.dart';

class CityDomain with EquatableMixin {
  final int id;
  final String name;
  final int? minTemperature;
  final int? maxTemperature;
  final int? currentTemperature;

  const CityDomain({
    required this.id,
    required this.name,
    this.minTemperature,
    this.maxTemperature,
    this.currentTemperature,
  });

  @override
  List<Object?> get props => [id, name, minTemperature, maxTemperature, currentTemperature];
}
