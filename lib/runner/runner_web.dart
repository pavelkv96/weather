import 'dart:async';

import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:weather/src/app.dart';
import 'package:weather/src/di/injection.dart';

void run() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDI();
      runApp(const App());
    },
    (error, stack) => l.e('Label: web_zoned_guarded, Error: $error', stack),
  );
}