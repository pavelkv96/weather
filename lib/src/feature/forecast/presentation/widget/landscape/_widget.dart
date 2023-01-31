part of 'landscape.dart';

class _AppBar extends StatelessWidget {
  final SelectedCityPresentation city;

  const _AppBar({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.router.push(const CitiesPage()),
          ),
          Expanded(
            child: Text(
              city.name,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayForecastContainer extends StatelessWidget {
  const _TodayForecastContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (hourlyForecast) => _TodayForecastWidget(hour: hourlyForecast.first),
          orElse: () => const _TodayForecastWidget(),
        );
      },
    );
  }
}

class _TodayForecastWidget extends StatelessWidget {
  final HourlyForecastPresentation? hour;

  const _TodayForecastWidget({
    Key? key,
    this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Column(
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
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(LocaleKeys.feature_forecast_daily_forecast),
              style: textTheme.headlineSmall,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dailyForecast.length,
                itemBuilder: (context, index) {
                  final day = dailyForecast[index];
                  return _DailyForecastLandscapeCard(day: day);
                },
              ),
            ),
            const _WeatherDataProviderWidget(),
          ],
        ),
      ),
    );
  }
}

class _DailyForecastLandscapeCard extends StatelessWidget {
  final DailyForecastPresentation day;

  const _DailyForecastLandscapeCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().today;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: 160,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset(
                      '$weatherIconAssetPath${day.dayWeatherType.icon}',
                      width: 70,
                      height: 40,
                    ),
                  ],
                ),
                Column(
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
                    Text(day.todayTemperature()),
                  ],
                ),
              ],
            ),
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

class _WeatherDataProviderWidget extends StatelessWidget {
  const _WeatherDataProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        tr(LocaleKeys.feature_forecast_weather_data_provider),
        textAlign: TextAlign.center,
        style: textTheme.labelSmall?.copyWith(fontSize: 12),
      ),
    );
  }
}
