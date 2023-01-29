import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/feature/cities/domain/model/cities_model.dart';

extension ListCitiesLocal on List<CityLocal> {
  List<CityDomain> toDomain() {
    return map(
      (city) => CityDomain(
        id: city.id,
        name: city.name,
        // minTemperature: null,
        // maxTemperature: null,
        // currentTemperature: null,
      ),
    ).toList();
  }
}
