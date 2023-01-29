import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/feature/selected_city/domain/model/selected_city_model.dart';
import 'package:weather/src/feature/selected_city/domain/use_case/use_case.dart';

extension CreateAndSelectCityInputExtension on CreateAndSelectCityInput {
  CityLocal toLocal() => CityLocal(id: id, name: name, area: area, country: country, isSelected: true);
}

extension CreateCityInputExtension on CreateCityInput {
  CityLocal toLocal() => CityLocal(id: id, name: name, area: area, country: country, isSelected: false);
}

extension CityLocalExtension on CityLocal {
  SelectedCityDomain toDomain() => SelectedCityDomain(id: id, name: name, area: area, country: country);
}
