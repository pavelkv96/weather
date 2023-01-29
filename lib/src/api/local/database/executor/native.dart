import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path;

QueryExecutor databaseExecutor() {
  return LazyDatabase(
    () async {
      final dbFolder = await path.getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'weather.db'));
      return NativeDatabase(file, logStatements: kDebugMode);
    },
  );
}
