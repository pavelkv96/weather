import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/cities/domain/model/cities_model.dart';

abstract class CitiesRepository {
  Future<Result<bool>> deleteCityById({required int cityId});

  Stream<Result<List<CityDomain>>> fetchAllCities();
}
