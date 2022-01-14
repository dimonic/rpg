import 'roller.dart';

class Attribute with Roller {
    Attribute([String this._name = "", String roll_str = "3d6"]) {
        value = RollStr(roll_str);
    }
    int ReRoll([String roll_str = "3d6"]) {
        value = RollStr(roll_str);
        return value;
    }
    void Describe() {
        print ("$_name = $value");
    }
    String _name;
    int value = 0;
}

class Attributes {
    Attributes(List<String> names) 
    : _attributes = new List<Attribute>.filled(names.length, Attribute()) {
        int c = 0;
        for (final name in names) {
            _attributes[c++]._name = name;
        }
     }
    List<Attribute> _attributes;
}