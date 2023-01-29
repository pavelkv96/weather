import 'package:drift/drift.dart';
import 'package:weather/src/api/local/database/database.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CityTable,
  ],
  daos: [
    CitiesDaoImpl,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({required QueryExecutor executor}) : super(executor);

  @override
  int get schemaVersion => 1;
}
