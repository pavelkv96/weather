import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/use_case/use_case.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/selected_city/domain/model/selected_city_model.dart';
import 'package:weather/src/feature/selected_city/domain/repositories/selected_city_repository.dart';

part '_changing_selected_city_use_case.dart';

part '_create_and_select_city_use_case.dart';

part '_create_city_use_case.dart';

part '_select_city_by_id_use_case.dart';

part '_unselect_current_city_use_case.dart';

class SelectCityByIdInput with EquatableMixin {
  final int id;

  const SelectCityByIdInput({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CreateAndSelectCityInput with EquatableMixin {
  final int id;
  final String name;
  final String area;
  final String country;

  const CreateAndSelectCityInput({
    required this.id,
    required this.name,
    required this.area,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, area, country];
}

class CreateCityInput with EquatableMixin {
  final int id;
  final String name;
  final String area;
  final String country;

  const CreateCityInput({
    required this.id,
    required this.name,
    required this.area,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, area, country];
}
