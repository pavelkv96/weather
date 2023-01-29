import 'package:equatable/equatable.dart';
import 'package:weather/src/common/util/constants/temperature.dart';
import 'package:weather/src/common/util/extension/int.dart';
import 'package:weather/src/feature/cities/domain/model/cities_model.dart';

class CityPresentation with EquatableMixin {
  final int id;
  final String name;
  final int? _maxTemperature;
  final int? _minTemperature;
  final int? _currentTemperature;

  const CityPresentation({
    required this.id,
    required this.name,
    required int? maxTemperature,
    required int? minTemperature,
    required int? currentTemperature,
  })  : _maxTemperature = maxTemperature,
        _minTemperature = minTemperature,
        _currentTemperature = currentTemperature;

  String todayTemperature({Temperature temp = Temperature.celsius}) {
    final max = _maxTemperature?.toTemperature(temp: temp);
    final min = _minTemperature?.toTemperature(temp: temp);
    return '${max != null ? '${max.round()}°' : '--'} / ${min != null ? '${min.round()}°' : '--'}';
  }

  String currentTemperature({Temperature temp = Temperature.celsius}) {
    final current = _currentTemperature?.toTemperature(temp: temp);
    return current != null ? '${current.round()}°' : '--';
  }

  @override
  List<Object?> get props => [id, name, _maxTemperature, _minTemperature, _currentTemperature];
}

extension ListCitiesDomain on List<CityDomain> {
  List<CityPresentation> toPresentation() {
    return map(
      (city) {
        return CityPresentation(
          id: city.id,
          name: city.name,
          maxTemperature: city.maxTemperature,
          minTemperature: city.minTemperature,
          currentTemperature: city.currentTemperature,
        );
      },
    ).toList();
  }
}
