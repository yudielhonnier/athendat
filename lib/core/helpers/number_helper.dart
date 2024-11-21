import 'dart:math' as math;

int getRandomColorNumber() {
  return (math.Random().nextDouble() * 0xFFFFFF).toInt();
}
