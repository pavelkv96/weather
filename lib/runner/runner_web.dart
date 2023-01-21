import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/app.dart';
import 'package:weather/src/common/util/error_util.dart';
import 'package:weather/src/di/injection.dart';

void run() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Localization
      await EasyLocalization.ensureInitialized();

      // Dependency injection
      await configureDI();
      runApp(const App());
    },
    (error, stack) => ErrorUtil.logError(error, stackTrace: stack, hint: 'web_zoned_guarded'),
  );
}
