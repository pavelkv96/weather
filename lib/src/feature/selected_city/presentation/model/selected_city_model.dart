import 'package:equatable/equatable.dart';
import 'package:weather/src/feature/selected_city/domain/model/selected_city_model.dart';

class SelectedCityPresentation with EquatableMixin {
  final int id;
  final String name;

  const SelectedCityPresentation({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

extension SelectedCityDomainExtension on SelectedCityDomain {
  SelectedCityPresentation toPresentation() {
    return SelectedCityPresentation(id: id, name: name);
  }
}
