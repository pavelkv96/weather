import 'package:equatable/equatable.dart';

class CitySearchDomain with EquatableMixin {
  final int id;
  final String city;
  final String area;
  final String country;

  const CitySearchDomain({
    required this.id,
    required this.city,
    required this.area,
    required this.country,
  });

  @override
  List<Object> get props => [id, city, area, country];
}
