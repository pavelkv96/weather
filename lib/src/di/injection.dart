import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/di/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDI({String? env}) async => locator.init(environment: env);
