import 'package:rpg/attribute.dart';
import 'package:test/test.dart';

Attribute chaTest = Attribute("Charisma", "4d6k3");

Attributes attr = Attributes();

void main() {
  test('Die roller Attribute base', () {
    expect(chaTest.value, greaterThan(2));
    expect(chaTest.value, lessThan(19));
  });
  test('Badly formed rollStr', () {
    int val = chaTest.reRoll("xyz");
    expect(val, 0);
  });
  test('Die roller 100 rolls of 3d6', () {
    List<int> stats = List<int>.filled(16, 0);
    int rolls = 100;
    int val = 0;
    int sum = 0;
    for (int c = 0; c < rolls; ++c) {
      val = chaTest.reRoll();
      sum += val;
      ++stats[val - 3];
      expect(chaTest.value, greaterThan(2));
      expect(chaTest.value, lessThan(19));
    }
    expect(sum / rolls, greaterThan(9));
    expect(sum / rolls, lessThan(12));
    print(stats);
  });
  test('Single die without ndice', () {
    chaTest.reRoll("d20");
    expect(chaTest.value, lessThan(21));
    expect(chaTest.value, greaterThan(0));
  });
  test('Empty specifier', () {
    chaTest.reRoll("");
    expect(chaTest.value, lessThan(7));
    expect(chaTest.value, greaterThan(0));
  });
  test('Multiple roll expressions', () {
    chaTest.reRoll("2d6 + 2d6");
    expect(chaTest.value, greaterThan(3));
    expect(chaTest.value, lessThan(25));
  });
  test('Damage + sneak attack', () {
    chaTest.reRoll('1d8+3 + 2d6');
    expect(chaTest.value, greaterThan(5));
    expect(chaTest.value, lessThan(24));
  });

  test('Attributes class', () {
    attr.describe();
    int res = attr.evalPoints();
    expect(res, greaterThan(0));
    expect(res, lessThan(34));
  });
}
