import 'package:drift/drift.dart';
import 'package:weather/src/api/local/local.dart';

part 'cities_dao.g.dart';

abstract class CitiesDao {
  Future<int> selectCityById(int cityId);

  Future<int> unselectCity();

  Stream<CityLocal?> fetchSelectedCity();

  Future<int> createCity(CityLocal city);

  Future<int> deleteCityById(int cityId);

  Future<CityLocal?> fetchCityById(int cityId);

  Stream<List<CityLocal>> fetchAllCities();

  Future<List<int>> fetchAllCitiesIds();
}

@DriftAccessor(tables: [CityTable])
class CitiesDaoImpl extends DatabaseAccessor<AppDatabase> with _$CitiesDaoImplMixin implements CitiesDao {
  CitiesDaoImpl(AppDatabase database) : super(database);

  @override
  Future<int> createCity(CityLocal city) {
    return into(cityTable).insert(city);
  }

  @override
  Future<int> deleteCityById(int cityId) {
    return (delete(cityTable)..where((table) => table.id.equals(cityId))).go();
  }

  @override
  Stream<List<CityLocal>> fetchAllCities() {
    return (select(cityTable)..orderBy([(table) => OrderingTerm(expression: table.name, mode: OrderingMode.asc)]))
        .watch();
  }

  @override
  Future<CityLocal?> fetchCityById(int cityId) {
    return (select(cityTable)..where((table) => table.id.equals(cityId))).getSingleOrNull();
  }

  @override
  Stream<CityLocal?> fetchSelectedCity() {
    return (select(cityTable)..where((table) => table.isSelected.equals(true))).watchSingleOrNull();
  }

  @override
  Future<int> selectCityById(int cityId) {
    return transaction(
      () async {
        await (update(cityTable)..where((table) => table.isSelected.equals(true))).write(
          const CityTableCompanion(isSelected: Value(false)),
        );
        return (update(cityTable)..where((table) => table.id.equals(cityId))).write(
          const CityTableCompanion(isSelected: Value(true)),
        );
      },
    );
  }

  @override
  Future<int> unselectCity() {
    return transaction(
      () => (update(cityTable)..where((table) => table.isSelected.equals(true))).write(
        const CityTableCompanion(isSelected: Value(false)),
      ),
    );
  }

  @override
  Future<List<int>> fetchAllCitiesIds() {
    return select(cityTable).map((row) => row.id).get();
  }
}
