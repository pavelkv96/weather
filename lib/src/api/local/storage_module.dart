import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/api/local/database/database.dart';
import 'package:weather/src/api/local/database/executor/shared.dart';

@module
abstract class StorageModule {
  @lazySingleton
  QueryExecutor queryExecutor() => databaseExecutor();

  @lazySingleton
  AppDatabase database(QueryExecutor executor) => AppDatabase(executor: executor);
}

@module
abstract class DaoModule {
  @lazySingleton
  CitiesDao citiesDao(AppDatabase database) => CitiesDaoImpl(database);

  @lazySingleton
  ForecastDao forecastDao(AppDatabase database) => ForecastDaoImpl(database);
}
