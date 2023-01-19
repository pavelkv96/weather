import 'dart:async';

import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:weather/src/app.dart';

void run() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const App());
    },
    (error, stack) => l.e('Label: io_zoned_guarded, Error: $error', stack),
  );
}
