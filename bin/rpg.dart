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

  Attributes dwarf = Attributes('conf/adnd-races.json', 'Dwarf');
  dwarf.describe();
  res = dwarf.evalPoints(pointCost1e);
  print("Point value for 3d6 in AD&D: $res");

  Attributes cavalier = Attributes('conf/ua-races.json', 'Human-cavalier');
  cavalier.describe();
  res = cavalier.evalPoints(pointCost1e);
  print("Point value for 3d6 in AD&D: $res");

  Attributes paladin = Attributes('conf/ua-races.json', 'Human-paladin');
  paladin.describe();
  res = paladin.evalPoints(pointCost1e);
  print("Point value for 3d6 in AD&D: $res");

  Attributes bard = Attributes('conf/dnd5e-races.json', 'Human-bard');
  bard.describe();
  res = bard.evalPoints(pointCost5e);
  print("Point value in 5e: $res");
}
