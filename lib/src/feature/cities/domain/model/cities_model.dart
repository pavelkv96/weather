import 'package:equatable/equatable.dart';

class CityDomain with EquatableMixin {
  final int id;
  final String name;
  final double? minTemperature;
  final double? maxTemperature;
  final double? currentTemperature;

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
