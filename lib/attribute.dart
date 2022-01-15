import 'roller.dart';

class Attribute with Roller {
  Attribute([this._name = "", String roll = "3d6"]) {
    value = RollStr(roll);
  }
  int reRoll([String roll = "3d6"]) {
    value = RollStr(roll);
    return value;
  }

  void describe() {
    print("$_name = $value");
  }

  String _name;
  int value = 0;
}

class Attributes {
  Attributes(List<String> names)
      : _attributes = List<Attribute>.filled(names.length, Attribute()) {
    int c = 0;
    for (final name in names) {
      _attributes[c++]._name = name;
    }
  }
  List<Attribute> _attributes;
}
