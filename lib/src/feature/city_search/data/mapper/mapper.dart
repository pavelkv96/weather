import 'package:weather/src/api/remote/remote.dart' show LocationRemote;
import 'package:weather/src/feature/city_search/domain/model/city_search_model.dart';

extension LocationsListRemote on List<LocationRemote> {
  List<CitySearchDomain> toDomain(Set<int> ids) {
    return map(
      (city) {
        final id = int.parse(city.key);
        return CitySearchDomain(
          id: id,
          city: city.name,
          area: city.area.name,
          country: city.country.name,
          isHas: ids.any((item) => item == id),
        );
      },
    ).toList();
  }
}
