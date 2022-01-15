import 'package:rpg/attribute.dart';
import 'package:test/test.dart';

Attribute char = Attribute("Charisma", "4d6k3");

void main() {
  test('Die roller Attribute base', () {
    expect(char.value, greaterThan(2));
    expect(char.value, lessThan(19));
  });
  test('Badly formed rollStr', () {
    int val = char.reRoll("xyz");
    expect(val, 0);
  });
  test('Die roller 100 rolls of 3d6', () {
    List<int> stats = List<int>.filled(16, 0);
    int rolls = 100;
    int val = 0;
    int sum = 0;
    for (int c = 0; c < rolls; ++c) {
      val = char.reRoll();
      sum += val;
      ++stats[val - 3];
      expect(char.value, greaterThan(2));
      expect(char.value, lessThan(19));
    }
    expect(sum / rolls, greaterThan(9));
    expect(sum / rolls, lessThan(12));
    print(stats);
  });
  test('Single die without ndice', () {
    char.reRoll("d20");
    expect(char.value, lessThan(21));
    expect(char.value, greaterThan(0));
  });
  test('Empty specifier', () {
    char.reRoll("");
    expect(char.value, lessThan(7));
    expect(char.value, greaterThan(0));
  });
  test('Multiple roll expressions', () {
    char.reRoll("2d6 + 2d6");
    expect(char.value, greaterThan(3));
    expect(char.value, lessThan(25));
  });
  test('Damage + sneak attack', () {
    char.reRoll('1d8+3 + 2d6');
    expect(char.value, greaterThan(5));
    expect(char.value, lessThan(24));
  });
}
