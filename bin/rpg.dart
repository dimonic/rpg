import '../lib/attribute.dart';

void main(List<String> arguments) {
  Attribute str = Attribute("Strength", "4d6k3");
  str.Describe();
  Attribute dex = Attribute("Dexterity", "4d6k3");
  dex.Describe();
  Attribute con = Attribute("Constitution", "4d6k3");
  con.Describe();
  Attribute int = Attribute("Intelligence", "4d6k3");
  int.Describe();
  Attribute wis = Attribute("Wisdom", "4d6k3");
  wis.Describe();
  Attribute cha = Attribute("Charisma", "4d6k3");
  cha.Describe();
  }
