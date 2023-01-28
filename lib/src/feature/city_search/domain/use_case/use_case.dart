import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/common/use_case/use_case.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/common/util/network/cancel_token_callback.dart';
import 'package:weather/src/feature/city_search/domain/model/city_search_model.dart';
import 'package:weather/src/feature/city_search/domain/repositories/city_search_repository.dart';

part '_city_search_use_case.dart';

class CitySearchInput with EquatableMixin {
  final String query;
  final String language;
  final CancelCallback? cancel;

  const CitySearchInput({
    required this.query,
    required this.language,
    this.cancel,
  });

  @override
  List<Object?> get props => [query, language, cancel];
}
