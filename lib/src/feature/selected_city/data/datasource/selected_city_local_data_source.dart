import 'package:injectable/injectable.dart';
import 'package:weather/src/api/local/local.dart';

abstract class SelectedCityLocalDataSource {
  Future<int> createCity(CityLocal city);

  Stream<CityLocal?> fetchSelectedCity();

  Future<int> selectCityById({required int id});

  Future<int> unselectCity();
}

@LazySingleton(as: SelectedCityLocalDataSource)
class SelectedCityLocalDataSourceImpl implements SelectedCityLocalDataSource {
  final CitiesDao _citiesDao;

  const SelectedCityLocalDataSourceImpl({
    required CitiesDao citiesDao,
  }) : _citiesDao = citiesDao;

  @override
  Stream<CityLocal?> fetchSelectedCity() {
    return _citiesDao.fetchSelectedCity();
  }

  @override
  Future<int> selectCityById({required int id}) {
    return _citiesDao.selectCityById(id);
  }

  @override
  Future<int> unselectCity() {
    return _citiesDao.unselectCity();
  }

  @override
  Future<int> createCity(CityLocal city) {
    return _citiesDao.createCity(city);
  }
}
