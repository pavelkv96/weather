import 'package:injectable/injectable.dart';
import 'package:weather/src/api/remote/remote.dart';
import 'package:weather/src/common/util/network/cancel_token_callback.dart';

// ignore: one_member_abstracts
abstract class CitySearchRemoteDataSource {
  Future<List<LocationRemote>> fetchAutocompleteListCities({
    required String query,
    required String language,
    CancelCallback? callback,
  });
}

@LazySingleton(as: CitySearchRemoteDataSource)
class CitiesRemoteDataSourceImpl implements CitySearchRemoteDataSource {
  final LocationService _locationService;

  CitiesRemoteDataSourceImpl({
    required LocationService locationService,
  }) : _locationService = locationService;

  @override
  Future<List<LocationRemote>> fetchAutocompleteListCities({
    required String query,
    required String language,
    CancelCallback? callback,
  }) {
    return _locationService.fetchAutocompleteListCities(query: query, language: language, token: callback?.token);
  }
}
