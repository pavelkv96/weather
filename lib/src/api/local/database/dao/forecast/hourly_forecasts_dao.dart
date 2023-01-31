import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';

part 'hourly_forecasts_dao.g.dart';

// ignore: one_member_abstracts
abstract class HourlyForecastsDao {
  Stream<List<HourlyForecastLocal>> fetchHourlyForecast({required int forecastId});
}

@DriftAccessor(tables: [HourlyForecastTable])
class HourlyForecastsDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$HourlyForecastsDaoImplMixin
    implements HourlyForecastsDao {
  HourlyForecastsDaoImpl(AppDatabase database) : super(database);

  @override
  Stream<List<HourlyForecastLocal>> fetchHourlyForecast({required int forecastId}) {
    return (select(hourlyForecastTable)..where((table) => table.forecastId.equals(forecastId))).watch();
  }
}
