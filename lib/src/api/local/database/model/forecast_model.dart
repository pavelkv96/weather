import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';

@DataClassName('ForecastLocal')
class ForecastTable extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();

  IntColumn get cityId =>
      integer().named('city_id').references(CityTable, #id, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();

  IntColumn get forecastType => integer().named('forecast_type').map(const ForecastConverter())();

  DateTimeColumn get lastUpdate => dateTime().named('last_update').withDefault(Constant(DateTime(2023)))();

  @override
  String get tableName => 'forecasts_info';

  @override
  List<Set<Column>> get uniqueKeys => [
    {cityId, forecastType},
  ];
}
