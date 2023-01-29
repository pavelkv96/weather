import 'package:injectable/injectable.dart';
import 'package:weather/src/common/error/handler.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/common/util/network/cancel_token_callback.dart';
import 'package:weather/src/feature/city_search/data/datasource/city_search_local_data_source.dart';
import 'package:weather/src/feature/city_search/data/datasource/city_search_remote_data_source.dart';
import 'package:weather/src/feature/city_search/data/mapper/mapper.dart';
import 'package:weather/src/feature/city_search/domain/model/city_search_model.dart';
import 'package:weather/src/feature/city_search/domain/repositories/city_search_repository.dart';

@LazySingleton(as: CitySearchRepository)
class CitySearchRepositoryImpl implements CitySearchRepository {
  final CitySearchLocalDataSource _citySearchLocalDataSource;
  final CitySearchRemoteDataSource _citySearchRemoteDataSource;

  const CitySearchRepositoryImpl({
    required CitySearchLocalDataSource citySearchLocalDataSource,
    required CitySearchRemoteDataSource citySearchRemoteDataSource,
  })  : _citySearchLocalDataSource = citySearchLocalDataSource,
        _citySearchRemoteDataSource = citySearchRemoteDataSource;

  @override
  Future<Result<List<CitySearchDomain>>> fetchAutocompleteListCities({
    required String query,
    required String language,
    CancelCallback? callback,
  }) async {
    try {
      final result = await _citySearchRemoteDataSource.fetchAutocompleteListCities(
        query: query,
        language: language,
        callback: callback,
      );
      final ids = await _citySearchLocalDataSource.fetchAllCitiesIds();
      return Result.success(result.toDomain(ids));
    } on Object catch (error, stack) {
      return Result.failure(handleError(error: error, stack: stack));
    }
  }
}
