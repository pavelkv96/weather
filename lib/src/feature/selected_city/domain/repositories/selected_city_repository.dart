import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/selected_city/domain/model/selected_city_model.dart';
import 'package:weather/src/feature/selected_city/domain/use_case/use_case.dart';

abstract class SelectedCityRepository {
  Stream<Result<SelectedCityDomain?>> changingSelectedCity();

  Future<Result<bool>> selectCityById({required int cityId});

  Future<Result<bool>> createAndSelectCity({required CreateAndSelectCityInput createAndSelectCityInput});

  Future<Result<bool>> createCity({required CreateCityInput createCityInput});

  Future<Result<bool>> unselectCity();
}
