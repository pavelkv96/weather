import 'package:injectable/injectable.dart';
import 'package:weather/src/common/error/error.dart';
import 'package:weather/src/common/util/constants/result.dart';
import 'package:weather/src/feature/selected_city/data/datasource/selected_city_local_data_source.dart';
import 'package:weather/src/feature/selected_city/data/mapper/mapper.dart';
import 'package:weather/src/feature/selected_city/domain/model/selected_city_model.dart';
import 'package:weather/src/feature/selected_city/domain/repositories/selected_city_repository.dart';
import 'package:weather/src/feature/selected_city/domain/use_case/use_case.dart';

@LazySingleton(as: SelectedCityRepository)
class SelectedCityRepositoryImpl implements SelectedCityRepository {
  final SelectedCityLocalDataSource _selectedCityLocalDataSource;

  const SelectedCityRepositoryImpl({
    required SelectedCityLocalDataSource selectedCityLocalDataSource,
  }) : _selectedCityLocalDataSource = selectedCityLocalDataSource;

  @override
  Stream<Result<SelectedCityDomain?>> changingSelectedCity() {
    return _selectedCityLocalDataSource.fetchSelectedCity().map((city) => Result.success(city?.toDomain()));
  }

  @override
  Future<Result<bool>> selectCityById({required int cityId}) async {
    try {
      final result = await _selectedCityLocalDataSource.selectCityById(id: cityId);
      return Result.success(result > 0);
    } on Object catch (error, stack) {
      return Result.failure(handleError(error: error, stack: stack));
    }
  }

  @override
  Future<Result<bool>> unselectCity() async {
    try {
      final result = await _selectedCityLocalDataSource.unselectCity();
      return Result.success(result >= 1);
    } on Object catch (error, stack) {
      return Result.failure(handleError(error: error, stack: stack));
    }
  }

  @override
  Future<Result<bool>> createAndSelectCity({required CreateAndSelectCityInput createAndSelectCityInput}) async {
    try {
      await _selectedCityLocalDataSource.createCity(createAndSelectCityInput.toLocal());
      return const Result.success(true);
    } on Object catch (error, stack) {
      return Result.failure(handleError(error: error, stack: stack));
    }
  }

  @override
  Future<Result<bool>> createCity({required CreateCityInput createCityInput}) async {
    try {
      await _selectedCityLocalDataSource.createCity(createCityInput.toLocal());
      return const Result.success(true);
    } on Object catch (error, stack) {
      return Result.failure(handleError(error: error, stack: stack));
    }
  }
}
