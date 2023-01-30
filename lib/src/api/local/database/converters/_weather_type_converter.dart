part of 'converters.dart';

class WeatherTypeConverter extends TypeConverter<WeatherType, int> {
  const WeatherTypeConverter();

  @override
  WeatherType fromSql(int fromDb) {
    switch (fromDb) {
      case 1:
        return WeatherType.sunny;
      case 2:
        return WeatherType.mostlySunny;
      case 3:
        return WeatherType.partlySunny;
      case 4:
        return WeatherType.dayIntermittentClouds;
      case 5:
        return WeatherType.hazySunshine;
      case 6:
        return WeatherType.dayMostlyCloudy;
      case 7:
        return WeatherType.cloudy;
      case 8:
        return WeatherType.overcast;
      case 11:
        return WeatherType.fog;
      case 12:
        return WeatherType.showers;
      case 13:
        return WeatherType.dayMostlyCloudyWithShowers;
      case 14:
        return WeatherType.partlySunnyWithShowers;
      case 15:
        return WeatherType.tStorms;
      case 16:
        return WeatherType.dayMostlyCloudyWithTStorms;
      case 17:
        return WeatherType.partlySunnyWithTStorms;
      case 18:
        return WeatherType.rain;
      case 19:
        return WeatherType.flurries;
      case 20:
        return WeatherType.dayMostlyCloudyWithFlurries;
      case 21:
        return WeatherType.partlySunnyWithFlurries;
      case 22:
        return WeatherType.snow;
      case 23:
        return WeatherType.dayMostlyCloudyWithSnow;
      case 24:
        return WeatherType.ice;
      case 25:
        return WeatherType.sleet;
      case 26:
        return WeatherType.freezingRain;
      case 29:
        return WeatherType.rainAndSnow;
      case 30:
        return WeatherType.hot;
      case 31:
        return WeatherType.cold;
      case 32:
        return WeatherType.windy;
      case 33:
        return WeatherType.clear;
      case 34:
        return WeatherType.mostlyClear;
      case 35:
        return WeatherType.partlyCloudy;
      case 36:
        return WeatherType.nightIntermittentClouds;
      case 37:
        return WeatherType.hazyMoonlight;
      case 38:
        return WeatherType.nightMostlyCloudy;
      case 39:
        return WeatherType.partlyCloudyWithShowers;
      case 40:
        return WeatherType.nightMostlyCloudyWithShowers;
      case 41:
        return WeatherType.partlyCloudyWithTStorms;
      case 42:
        return WeatherType.nightMostlyCloudyWithTStorms;
      case 43:
        return WeatherType.nightMostlyCloudyWithFlurries;
      case 44:
        return WeatherType.nightMostlyCloudyWithSnow;
      default:
        return WeatherType.unknown;
    }
  }

  @override
  int toSql(WeatherType value) => value.type;
}
