import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/common/widget/widget.dart';
import 'package:weather/src/di/injection.dart';
import 'package:weather/src/feature/city_search/presentation/bloc/city_search_bloc.dart';
import 'package:weather/src/feature/city_search/presentation/widget/widget.dart';

class CitySearchScreen extends StatelessWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CitySearchBloc>(
      create: (context) => locator<CitySearchBloc>(),
      child: const OrientationLayout(
        portrait: CitySearchPortrait(),
      ),
    );
  }
}
