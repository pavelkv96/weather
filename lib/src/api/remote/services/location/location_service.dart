import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather/src/api/remote/services/location/location.dart';

part 'location_service.g.dart';

@RestApi()
abstract class LocationService {
  factory LocationService(Dio dio, {String baseUrl}) = _LocationService;

  @GET('locations/v1/cities/autocomplete')
  Future<List<LocationRemote>> fetchAutocompleteListCities({
    @Query('q') required String query,
    @Query('language') required String language,
    CancelToken? token,
  });
}
