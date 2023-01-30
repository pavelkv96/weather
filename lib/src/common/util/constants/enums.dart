import 'package:weather/generated/locale_keys.g.dart';

enum Forecast {
  unknown(type: 0),
  oneHour(type: 1),
  twelveHours(type: 2),
  oneDay(type: 3),
  fiveDays(type: 4);

  final int type;

  const Forecast({required this.type});
}

enum WeatherType {
  unknown(type: 0),
  sunny(type: 1),
  mostlySunny(type: 2),
  partlySunny(type: 3),
  dayIntermittentClouds(type: 4),
  hazySunshine(type: 5),
  dayMostlyCloudy(type: 6),
  cloudy(type: 7),
  overcast(type: 8),
  fog(type: 11),
  showers(type: 12),
  dayMostlyCloudyWithShowers(type: 13),
  partlySunnyWithShowers(type: 14),
  tStorms(type: 15),
  dayMostlyCloudyWithTStorms(type: 16),
  partlySunnyWithTStorms(type: 17),
  rain(type: 18),
  flurries(type: 19),
  dayMostlyCloudyWithFlurries(type: 20),
  partlySunnyWithFlurries(type: 21),
  snow(type: 22),
  dayMostlyCloudyWithSnow(type: 23),
  ice(type: 24),
  sleet(type: 25),
  freezingRain(type: 26),
  rainAndSnow(type: 29),
  hot(type: 30),
  cold(type: 31),
  windy(type: 32),
  clear(type: 33),
  mostlyClear(type: 34),
  partlyCloudy(type: 35),
  nightIntermittentClouds(type: 36),
  hazyMoonlight(type: 37),
  nightMostlyCloudy(type: 38),
  partlyCloudyWithShowers(type: 39),
  nightMostlyCloudyWithShowers(type: 40),
  partlyCloudyWithTStorms(type: 41),
  nightMostlyCloudyWithTStorms(type: 42),
  nightMostlyCloudyWithFlurries(type: 43),
  nightMostlyCloudyWithSnow(type: 44);

  final int type;

  const WeatherType({required this.type});

  String get translateKey => '${LocaleKeys.core_weather}.$type';

  String get icon => '$type.png';
}
