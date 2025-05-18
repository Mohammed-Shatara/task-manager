import 'dart:math';

extension RadianConverter on double {
  double toRadian() => this * pi / 180;
}
