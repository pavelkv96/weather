part of 'portrait.dart';

class _CitiesListWidgetIdle extends StatelessWidget {
  const _CitiesListWidgetIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}

class _CitiesListWidgetSuccess extends StatelessWidget {
  final List<CityPresentation> cities;

  const _CitiesListWidgetSuccess({
    Key? key,
    required this.cities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCityBloc = context.watch<SelectedCityBloc>();
    final selectedCity = selectedCityBloc.state.whenOrNull(selected: (city) => city.id);
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return Card(
          key: ValueKey('cities-success-list-item-card${city.id}'),
          child: Dismissible(
            key: ValueKey('cities-success-list-item-card-dismiss${city.id}'),
            dismissThresholds: const {DismissDirection.endToStart: 0.6},
            direction: DismissDirection.endToStart,
            background: const _DismissibleBackgroundContainer(),
            child: _CityItem(
              city: city,
              isSelected: selectedCity == city.id,
              onTap: () => selectedCityBloc.add(SelectedCityEvent.selectCity(id: city.id)),
            ),
            onDismissed: (_) => context.read<CitiesListBloc>().add(CitiesListEvent.deleteCity(id: city.id)),
          ),
        );
      },
    );
  }
}

class _CitiesListWidgetError extends StatelessWidget {
  final String message;

  const _CitiesListWidgetError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          tr(message),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CitiesListWidgetEmpty extends StatelessWidget {
  const _CitiesListWidgetEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          tr(LocaleKeys.feature_cities_state_empty),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CityItem extends StatelessWidget {
  final bool isSelected;
  final CityPresentation city;
  final VoidCallback onTap;

  const _CityItem({
    Key? key,
    required this.city,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    return Stack(
      children: [
        /*WeatherBg(
          height: 72,
          width: MediaQuery.of(context).size.width,
          weatherType: WeatherType.foggy,
        ),*/
        RadioListTile(
          value: isSelected,
          onChanged: (_) => onTap(),
          groupValue: true,
          title: Text(
            city.name,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            city.todayTemperature(),
            style: textTheme.titleMedium?.copyWith(),
          ),
          secondary: Text(
            city.currentTemperature(),
            style: textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}

class _DismissibleBackgroundContainer extends StatelessWidget {
  const _DismissibleBackgroundContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(16),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}
