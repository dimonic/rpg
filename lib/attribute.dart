import 'roller.dart';
import 'dart:convert';
import 'dart:io';

class Attribute with Roller {
  Attribute([this._name = "", String roll = "3d6"]) {
    value = rollDiceStr(roll);
  }
  int reRoll([String roll = "3d6"]) {
    value = rollDiceStr(roll);
    return value;
  }

  void describe() {
    print("$_name = $value");
  }

  String _name;
  int value = 0;
}

const List<int> pointCost5e = [
  -5,
  -4,
  -3,
  -2,
  -1,
  0,
  1,
  2,
  3,
  4,
  5,
  7,
  9,
  12,
  15,
  19,
  23
];

const List<int> pointCost1e = [
  -5,
  -4,
  -3,
  -2,
  -1,
  0,
  0,
  0,
  0,
  0,
  0,
  1,
  2,
  3,
  4,
  5,
  6
];

class Attributes {
  Attributes(String fileName, this._race) : _attributes = [] {
    var file = File(fileName);
    String json = file.readAsStringSync(encoding: ascii);
    var charMap = jsonDecode(json);
    var chosen = charMap[_race];
    var attributes = chosen["attribute"];
    for (final attr in attributes) {
      _attributes.add(Attribute(attr["name"], attr["roll_ni"]));
    }
  }

  void rollAttributes([dieStr = "4d6k3"]) {
    for (final attr in _attributes) {
      attr.reRoll(dieStr);
    }
  }

  void describe() {
    print(_race);
    for (final attr in _attributes) {
      attr.describe();
    }
  }

  int evalPoints([List<int> costArray = pointCost5e]) {
    int res = 0;
    for (final attr in _attributes) {
      if (attr.value > 2 && attr.value < 20) {
        res += costArray[attr.value - 3];
      }
    }
    return res;
  }

  final String _race;
  List<Attribute> _attributes;
}
