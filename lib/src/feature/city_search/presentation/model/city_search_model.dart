import 'package:equatable/equatable.dart';
import 'package:weather/src/feature/city_search/domain/model/city_search_model.dart';

class CitySearchPresentation with EquatableMixin {
  final int id;
  final String name;
  final String country;
  final String area;
  final bool isHas;

  const CitySearchPresentation({
    required this.id,
    required this.name,
    required this.country,
    required this.area,
    required this.isHas,
  });

  String get location => [area, country].join(', ');

  @override
  List<Object?> get props => [id, name, country, area, isHas];
}

extension CitiesSearchListDomain on List<CitySearchDomain> {
  List<CitySearchPresentation> toPresentation() {
    return map(
      (city) {
        return CitySearchPresentation(
          id: city.id,
          name: city.city,
          country: city.country,
          area: city.area,
          isHas: city.isHas,
        );
      },
    ).toList();
  }
}
