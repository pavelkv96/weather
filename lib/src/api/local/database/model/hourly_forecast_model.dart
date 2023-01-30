import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';

@DataClassName('HourlyForecastLocal')
class HourlyForecastTable extends Table {
  IntColumn get forecastId =>
      integer().named('id').references(ForecastTable, #id, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime().named('date')();

  RealColumn get temperature => real().named('temperature').nullable()();

  IntColumn get weatherType => integer().named('weather_type').map(const WeatherTypeConverter())();

  @override
  String get tableName => 'hourly_forecasts';

  @override
  List<Set<Column>> get uniqueKeys => [
        {forecastId, date},
      ];
}
