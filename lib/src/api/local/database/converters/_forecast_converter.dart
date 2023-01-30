part of 'converters.dart';

class ForecastConverter extends TypeConverter<Forecast, int> {
  const ForecastConverter();

  @override
  Forecast fromSql(int fromDb) {
    switch (fromDb) {
      case 1:
        return Forecast.oneHour;
      case 2:
        return Forecast.twelveHours;
      case 3:
        return Forecast.oneDay;
      case 4:
        return Forecast.fiveDays;
      default:
        return Forecast.unknown;
    }
  }

  @override
  int toSql(Forecast value) => value.type;
}
