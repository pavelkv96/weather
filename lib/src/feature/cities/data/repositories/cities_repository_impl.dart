import 'package:injectable/injectable.dart';
import 'package:weather/src/common/error/error.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/cities/data/datasource/cities_local_data_source.dart';
import 'package:weather/src/feature/cities/data/mapper/mapper.dart';
import 'package:weather/src/feature/cities/domain/model/cities_model.dart';
import 'package:weather/src/feature/cities/domain/repositories/cities_repository.dart';

@LazySingleton(as: CitiesRepository)
class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesLocalDataSource _citiesLocalDataSource;

  CitiesRepositoryImpl({
    required CitiesLocalDataSource citiesLocalDataSource,
  }) : _citiesLocalDataSource = citiesLocalDataSource;

  @override
  Future<Result<bool>> deleteCityById({required int cityId}) async {
    try {
      final result = await _citiesLocalDataSource.deleteCityById(cityId: cityId);
      return Result.success(result > 0);
    } on Object catch (error, stack) {
      return Result.failure(handleError(error: error, stack: stack));
    }
  }

  @override
  Stream<Result<List<CityDomain>>> fetchAllCities() async* {
    try {
      yield* _citiesLocalDataSource.fetchAllCities().map((items) => Result.success(items.toDomain()));
    } on Object catch (error, stack) {
      yield Result.failure(handleError(error: error, stack: stack));
    }
  }
}
