import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/use_case/use_case.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/cities/domain/model/cities_model.dart';
import 'package:weather/src/feature/cities/domain/repositories/cities_repository.dart';

part '_delete_city_by_id_use_case.dart';

part '_fetch_all_cities_use_case.dart';

class CityDeleteInput with EquatableMixin {
  final int id;

  const CityDeleteInput({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
