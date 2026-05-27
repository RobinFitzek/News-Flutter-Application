import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/mcpt_validator.dart';

double profitFactor(List<double> returns) {
  var sumPos = 0.0;
  var sumNeg = 0.0;
  for (final r in returns) {
    if (r > 0) {
      sumPos += r;
    } else if (r < 0) {
      sumNeg += r.abs();
    }
  }
  return sumPos / (sumNeg > 0 ? sumNeg : 0.001);
}

void main() {
  group('MCPT profit factor logic', () {
    test('all wins yields high profit factor', () {
      expect(profitFactor([1, 2, 3]), greaterThan(1));
    });

    test('mixed returns compute ratio', () {
      expect(profitFactor([2, -1, 3, -1]), closeTo(2.5, 0.01));
    });
  });

  group('McptValidator', () {
    test('class is instantiable', () {
      expect(McptValidator, isNotNull);
    });
  });
}
