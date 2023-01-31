import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';

part 'daily_forecasts_dao.g.dart';

// ignore: one_member_abstracts
abstract class DailyForecastsDao {
  Stream<List<DailyForecastLocal>> fetchDailyForecast({required int forecastId});
}

@DriftAccessor(tables: [DailyForecastTable])
class DailyForecastsDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$DailyForecastsDaoImplMixin
    implements DailyForecastsDao {
  DailyForecastsDaoImpl(AppDatabase database) : super(database);

  @override
  Stream<List<DailyForecastLocal>> fetchDailyForecast({required int forecastId}) {
    return (select(dailyForecastTable)..where((table) => table.forecastId.equals(forecastId))).watch();
  }
}
