import 'package:injectable/injectable.dart';
import 'package:weather/src/api/local/local.dart';

// ignore: one_member_abstracts
abstract class CitySearchLocalDataSource {
  Future<Set<int>> fetchAllCitiesIds();
}

@LazySingleton(as: CitySearchLocalDataSource)
class CitiesLocalDataSourceImpl implements CitySearchLocalDataSource {
  final CitiesDao _citiesDao;

  CitiesLocalDataSourceImpl({
    required CitiesDao citiesDao,
  }) : _citiesDao = citiesDao;

  @override
  Future<Set<int>> fetchAllCitiesIds() async {
    return (await _citiesDao.fetchAllCitiesIds()).toSet();
  }
}
