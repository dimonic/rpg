import 'roller.dart';
import 'dart:convert';
import 'dart:io';

class Attribute with Roller {
  Attribute([this._name = "", String roll = "3d6"]) {
    print("Rolling $roll for $_name");
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

const charGen5e = {
  'Strength': '4d6k3',
  'Dexterity': '4d6k3',
  'Constitution': '4d6k3',
  'Intelligence': '4d6k3',
  'Wisdom': '4d6k3',
  'Charisma': '4d6k3'
};

const charGen1e = {
  'Strength': '4d6k3',
  'Intelligence': '4d6k3',
  'Wisdom': '4d6k3',
  'Dexterity': '4d6k3',
  'Constitution': '4d6k3',
  'Charisma': '4d6k3'
};

const charGenUaCavalier = {
  'Strength': '8d6k3',
  'Intelligence': '6d6k3',
  'Wisdom': '4d6k3',
  'Dexterity': '7d6k3',
  'Constitution': '9d6k3',
  'Charisma': '3d6k3'
};

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
  Attributes(String fileName, String race) : _attributes = [] {
    var file = File(fileName);
    String json = file.readAsStringSync(encoding: ascii);
    var charMap = jsonDecode(json);
    var chosen = charMap[race];
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

  List<Attribute> _attributes;
}
