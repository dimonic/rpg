import '../lib/attribute.dart';

void main(List<String> arguments) {
  Attributes human = Attributes('conf/adnd-races.json', 'Human');
  human.describe();
  var res = human.evalPoints(pointCost1e);
  print("Point value for 3d6 in AD&D: $res");

  Attributes elf = Attributes('conf/adnd-races.json', 'Elf');
  elf.describe();
  res = elf.evalPoints(pointCost1e);
  print("Point value for 3d6 in AD&D: $res");
}
