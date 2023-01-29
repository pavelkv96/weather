import 'package:injectable/injectable.dart';
import 'package:weather/src/api/local/local.dart';

abstract class CitiesLocalDataSource {
  Future<int> deleteCityById({required int cityId});

  Stream<List<CityLocal>> fetchAllCities();
}

@LazySingleton(as: CitiesLocalDataSource)
class CitiesLocalDataSourceImpl implements CitiesLocalDataSource {
  final CitiesDao _citiesDao;

  const CitiesLocalDataSourceImpl({
    required CitiesDao citiesDao,
  }) : _citiesDao = citiesDao;

  @override
  Future<int> deleteCityById({required int cityId}) {
    return _citiesDao.deleteCityById(cityId);
  }

  @override
  Stream<List<CityLocal>> fetchAllCities() async* {
    yield* _citiesDao.fetchAllCities();
  }
}
