import 'package:injectable/injectable.dart';
import 'package:weather/src/navigation/navigation.dart';

@module
abstract class NavigationModule {
  @lazySingleton
  AppRouter appRouter() => AppRouter();
}
