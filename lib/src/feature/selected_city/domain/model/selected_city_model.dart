import 'package:equatable/equatable.dart';

class SelectedCityDomain with EquatableMixin {
  final int id;
  final String name;
  final String area;
  final String country;

  const SelectedCityDomain({
    required this.id,
    required this.name,
    required this.area,
    required this.country,
  });

  @override
  List<Object> get props => [id, name, area, country];
}
