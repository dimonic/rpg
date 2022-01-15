import '../lib/attribute.dart';

void main(List<String> arguments) {
  Attribute str = Attribute("Strength", "4d6k3");
  str.describe();
  Attribute dex = Attribute("Dexterity", "4d6k3");
  dex.describe();
  Attribute con = Attribute("Constitution", "4d6k3");
  con.describe();
  Attribute int = Attribute("Intelligence", "4d6k3");
  int.describe();
  Attribute wis = Attribute("Wisdom", "4d6k3");
  wis.describe();
  Attribute cha = Attribute("Charisma", "4d6k3");
  cha.describe();
}
