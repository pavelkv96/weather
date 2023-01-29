import 'package:drift/backends.dart' show QueryExecutor;
import 'package:drift/web.dart';

QueryExecutor databaseExecutor() {
  return WebDatabase.withStorage(DriftWebStorage.indexedDb('weather.db'));
}
