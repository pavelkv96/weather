import 'package:drift/drift.dart';

@DataClassName('CityLocal')
class CityTable extends Table {
  IntColumn get id => integer().named('id').unique()();

  TextColumn get name => text().named('name')();

  TextColumn get area => text().named('area')();

  TextColumn get country => text().named('country')();

  BoolColumn get isSelected => boolean().named('is_selected').withDefault(const Constant(false))();

  @override
  String get tableName => 'cities';
}
