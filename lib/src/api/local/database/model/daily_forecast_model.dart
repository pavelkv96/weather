import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';

@DataClassName('DailyForecastLocal')
class DailyForecastTable extends Table {
  IntColumn get forecastId =>
      integer().named('id').references(ForecastTable, #id, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();

  DateTimeColumn get day => dateTime().named('date')();

  RealColumn get temperatureMin => real().named('temperature_min').nullable()();

  RealColumn get temperatureMax => real().named('temperature_max').nullable()();

  IntColumn get dayWeatherType => integer().named('day_weather_type')();

  IntColumn get nightWeatherType => integer().named('night_weather_type')();

  @override
  String get tableName => 'daily_forecasts';

  @override
  List<Set<Column>> get uniqueKeys => [
        {forecastId, day},
      ];
}
