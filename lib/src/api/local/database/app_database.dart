import 'package:drift/drift.dart';
import 'package:weather/src/api/local/database/database.dart';
import 'package:weather/src/common/util/constants/enums.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CityTable,
    ForecastTable,
    DailyForecastTable,
    HourlyForecastTable,
  ],
  daos: [
    CitiesDaoImpl,
    DailyForecastsDaoImpl,
    ForecastDaoImpl,
    HourlyForecastsDaoImpl,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({required QueryExecutor executor}) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (_) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
