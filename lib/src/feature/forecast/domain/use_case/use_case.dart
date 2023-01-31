import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/use_case/use_case.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/forecast/domain/model/forecast_model.dart';
import 'package:weather/src/feature/forecast/domain/repositories/forecast_repository.dart';

part '_fetch_daily_forecast_by_city_id_use_case.dart';

part '_fetch_hourly_forecast_by_city_id_use_case.dart';

class CityIdInput with EquatableMixin {
  final int id;

  const CityIdInput({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
