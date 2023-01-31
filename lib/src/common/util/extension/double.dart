import 'package:weather/src/common/util/constants/temperature.dart';

extension IntExtension on double {
  double toCelsius() {
    return (this - 32) * 5 / 9;
  }

  double toTemperature({Temperature temp = Temperature.fahrenheit}) {
    return temp == Temperature.celsius ? toCelsius() : this;
  }
}
