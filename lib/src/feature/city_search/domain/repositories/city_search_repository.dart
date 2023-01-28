import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/common/util/network/cancel_token_callback.dart';
import 'package:weather/src/feature/city_search/domain/model/city_search_model.dart';

// ignore: one_member_abstracts
abstract class CitySearchRepository {
  Future<Result<List<CitySearchDomain>>> fetchAutocompleteListCities({
    required String query,
    required String language,
    CancelCallback? callback,
  });
}
