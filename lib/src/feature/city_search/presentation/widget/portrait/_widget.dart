part of 'portrait.dart';

class AppBarSearchForm extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const AppBarSearchForm({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<AppBarSearchForm> createState() => _AppBarSearchFormState();
}

class _AppBarSearchFormState extends State<AppBarSearchForm> {
  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _editingController?.clear();
    _editingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: (value) => setState(() => widget.onChanged(value)),
      controller: _editingController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: tr(LocaleKeys.feature_city_search_appbar_search_hint),
      ),
    );
  }
}

class _CitySearchWidgetInitial extends StatelessWidget {
  const _CitySearchWidgetInitial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          tr(LocaleKeys.feature_city_search_state_initial),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CitySearchWidgetLoading extends StatelessWidget {
  const _CitySearchWidgetLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}

class _CitySearchWidgetSuccess extends StatelessWidget {
  final List<CitySearchPresentation> cities;

  const _CitySearchWidgetSuccess({
    Key? key,
    required this.cities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCityBloc = context.read<SelectedCityBloc>();
    final selectedCity = selectedCityBloc.state.whenOrNull(selected: (city) => city);
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(height: 1),
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return _CitySearchItemWidget(
          key: ValueKey(city.id),
          city: city,
          onTap: () {
            selectedCityBloc.add(_handleEvent(selectedCity, city));
            context.router.pop();
          },
        );
      },
    );
  }

  SelectedCityEvent _handleEvent(SelectedCityPresentation? selectedCity, CitySearchPresentation city) {
    if (selectedCity != null) {
      return SelectedCityEvent.createCity(id: city.id, name: city.name, area: city.area, country: city.country);
    } else {
      return SelectedCityEvent.createAndSelectCity(
        id: city.id,
        name: city.name,
        area: city.area,
        country: city.country,
      );
    }
  }
}

class _CitySearchWidgetEmpty extends StatelessWidget {
  const _CitySearchWidgetEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          tr(LocaleKeys.feature_city_search_state_empty),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CitySearchWidgetError extends StatelessWidget {
  final String message;
  final VoidCallback onRetryTap;

  const _CitySearchWidgetError({
    Key? key,
    required this.message,
    required this.onRetryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr(message),
              textAlign: TextAlign.center,
            ),
            OutlinedButton(
              onPressed: onRetryTap,
              child: Text(tr(LocaleKeys.core_widget_button_try_again)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CitySearchItemWidget extends StatelessWidget {
  final CitySearchPresentation city;
  final VoidCallback onTap;

  const _CitySearchItemWidget({
    required Key key,
    required this.city,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: city.isHas ? null : onTap,
      title: Text(city.name),
      subtitle: Text(city.location),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_CitySearchItemTrailingWidget(isHas: city.isHas)],
      ),
    );
  }
}

class _CitySearchItemTrailingWidget extends StatelessWidget {
  final bool isHas;

  const _CitySearchItemTrailingWidget({
    Key? key,
    required this.isHas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    final iconTheme = themeData.iconTheme;
    if (isHas) {
      return Text(
        tr(LocaleKeys.feature_city_search_state_success_added_city),
        style: textTheme.titleSmall?.copyWith(
          color: iconTheme.color,
        ),
      );
    } else {
      return Icon(
        Icons.add,
        color: iconTheme.color,
      );
    }
  }
}
