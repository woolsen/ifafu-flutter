import 'dart:math';

extension DoubleExt on double {
  double roundTo(int n) {
    return (this * pow(10, n)).round() / pow(10, n);
  }
}
