export 'package:weather/src/api/local/database/executor/unsupported.dart'
    if (dart.library.ffi) 'package:weather/src/api/local/database/executor/native.dart'
    if (dart.library.html) 'package:weather/src/api/local/database/executor/web.dart';
