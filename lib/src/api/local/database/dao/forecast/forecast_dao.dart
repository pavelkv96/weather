import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';
import 'package:weather/src/common/util/constants/enums.dart';

part 'forecast_dao.g.dart';

abstract class ForecastDao {
  Future<ForecastLocal> fetchLastUpdate({required int cityId, required Forecast forecast});

  Future<void> updateDailyForecasts({required int forecastId, required List<DailyForecastLocal> dailyForecasts});

  Future<void> updateHourlyForecasts({required int forecastId, required List<HourlyForecastLocal> hourlyForecasts});
}

@DriftAccessor(tables: [ForecastTable, DailyForecastTable, HourlyForecastTable])
class ForecastDaoImpl extends DatabaseAccessor<AppDatabase> with _$ForecastDaoImplMixin implements ForecastDao {
  ForecastDaoImpl(super.attachedDatabase);

  @override
  Future<ForecastLocal> fetchLastUpdate({required int cityId, required Forecast forecast}) async {
    return (await (select(forecastTable)
              ..where((table) => table.cityId.equals(cityId) & table.forecastType.equals(forecast.type)))
            .getSingleOrNull()) ??
        (await into(forecastTable)
            .insertReturning(ForecastTableCompanion.insert(cityId: cityId, forecastType: forecast)));
  }

  @override
  Future<void> updateDailyForecasts({required int forecastId, required List<DailyForecastLocal> dailyForecasts}) {
    return transaction(
      () async {
        final entry = ForecastTableCompanion(lastUpdate: Value(DateTime.now()));
        await (update(forecastTable)..where((table) => table.id.equals(forecastId))).write(entry);
        await (delete(dailyForecastTable)..where((table) => table.forecastId.equals(forecastId))).go();
        return batch((batch) => batch.insertAll(dailyForecastTable, dailyForecasts));
      },
    );
  }

  @override
  Future<void> updateHourlyForecasts({required int forecastId, required List<HourlyForecastLocal> hourlyForecasts}) {
    return transaction(
      () async {
        final entry = ForecastTableCompanion(lastUpdate: Value(DateTime.now()));
        await (update(forecastTable)..where((table) => table.id.equals(forecastId))).write(entry);
        await (delete(hourlyForecastTable)..where((table) => table.forecastId.equals(forecastId))).go();
        return batch((batch) => batch.insertAll(hourlyForecastTable, hourlyForecasts));
      },
    );
  }
}
