part of 'portrait.dart';

class _TodayForecast extends StatelessWidget {
  final HourlyForecastPresentation? hour;

  const _TodayForecast({
    Key? key,
    this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return SizedBox(
      height: 360,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TodayTemperatureWidget(temperature: hour?.temperature() ?? '--'),
          _TodayWeatherWidget(weather: hour?.weatherType.translateKey ?? LocaleKeys.core_weather_0),
          const SizedBox(height: 24),
          Text(
            hour?.date.toStringFormat(pattern: 'HH:mm', locale: tr(LocaleKeys.core_locale_time)) ?? '--:--',
            style: textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class _TodayTemperatureWidget extends StatelessWidget {
  final String temperature;

  const _TodayTemperatureWidget({
    Key? key,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          temperature,
          style: textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          Temperature.celsius.type,
          style: textTheme.displaySmall,
        ),
      ],
    );
  }
}

class _TodayWeatherWidget extends StatelessWidget {
  final String weather;

  const _TodayWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Text(
      tr(weather),
      style: textTheme.headlineSmall,
    );
  }
}

class _DailyForecastSuccess extends StatelessWidget {
  final List<DailyForecastPresentation> dailyForecast;

  const _DailyForecastSuccess({
    Key? key,
    required this.dailyForecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.feature_forecast_daily_forecast),
            style: textTheme.headlineSmall,
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dailyForecast.length,
              itemBuilder: (context, index) {
                final day = dailyForecast[index];
                return _DailyForecastPortraitCard(day: day);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HourlyForecastSuccess extends StatelessWidget {
  final List<HourlyForecastPresentation> hourlyForecast;

  const _HourlyForecastSuccess({
    Key? key,
    required this.hourlyForecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.feature_forecast_hourly_forecast),
            style: textTheme.headlineSmall,
          ),
          SizedBox(
            height: 96,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyForecast.length,
              itemBuilder: (context, index) {
                final hour = hourlyForecast[index];
                return _HourlyForecastPortraitCard(hour: hour);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyForecastPortraitCard extends StatelessWidget {
  final DailyForecastPresentation day;

  const _DailyForecastPortraitCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().today;
    return Card(
      child: SizedBox.square(
        dimension: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (today.difference(day.date).inDays == 0)
              Text(tr(LocaleKeys.feature_forecast_today))
            else
              Text(
                day.date.toStringFormat(
                  pattern: 'EEE, dd MMM',
                  locale: tr(LocaleKeys.core_locale_time),
                ),
              ),
            Image.asset(
              '$weatherIconAssetPath${day.dayWeatherType.icon}',
              width: 70,
              height: 40,
            ),
            Text(day.todayTemperature()),
            Text(
              tr(day.dayWeatherType.translateKey),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}

class _HourlyForecastPortraitCard extends StatelessWidget {
  final HourlyForecastPresentation hour;

  const _HourlyForecastPortraitCard({
    Key? key,
    required this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 96,
        width: 72,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(hour.date.toStringFormat(pattern: 'HH:mm', locale: tr(LocaleKeys.core_locale_time))),
            Image.asset(
              'resources/weather/icons/${hour.weatherType.icon}',
              width: 60,
              height: 36,
            ),
            Text(
              hour.temperature(),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDataProviderWidget extends StatelessWidget {
  const _WeatherDataProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        tr(LocaleKeys.feature_forecast_weather_data_provider),
        textAlign: TextAlign.center,
        style: textTheme.labelSmall?.copyWith(fontSize: 12),
      ),
    );
  }
}
