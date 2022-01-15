import 'dart:math';

class RollSpec {
  RollSpec(
      {int this.nDice = 1,
      int this.die = 6,
      int this.reroll = 0,
      int this.dropDice = 0,
      int this.bonus = 0,
      int this.minTotal = 1});
  int nDice;
  int die;
  int reroll;
  int dropDice;
  int bonus;
  int minTotal;
}

mixin Roller {
  Iterable<RollSpec> ParseStr(String rollStr) {
    List<RollSpec> rss = <RollSpec>[];
    RollSpec rs = RollSpec();
    RegExp rollExpr = RegExp(r'\s*(\d+)?\s*([dD])\s*(\d+)([^\s]*)?\s*(\+)?');
    Iterable<RegExpMatch> matches = rollExpr.allMatches(rollStr);
    for (final match in matches) {
      print(match.input);
      if (match.group(1) != null) {
        rs.nDice = int.parse(match.group(1)!);
      }
      rs.die = int.parse(match.group(3)!);
      if (match.group(4) != null) {
        RegExp modExpr = RegExp(r'\s*([rRkK+-])(\d+)');
        Iterable<RegExpMatch> mods = modExpr.allMatches(match.group(4)!);
        for (final mod in mods) {
          int value = int.parse(mod.group(2)!);
          switch (mod.group(1)) {
            case 'r':
            case 'R':
              {
                rs.reroll = value;
              }
              break;
            case 'k':
            case 'K':
              {
                rs.dropDice = rs.nDice - value;
              }
              break;
            case '+':
              {
                rs.bonus = value;
              }
              break;
            case '-':
              {
                rs.bonus = -value;
              }
              break;
          }
        }
      }
      rss.add(rs);
    }
    return rss;
  }

  /// \brief Roll dice based on str <ndice> d <die> [r reroll k keep +- bonus]
  int RollStr(String rollStr) {
    int res = 0;
    if (rollStr.isEmpty) {
      res = Roll(RollSpec());
    } else {
      Iterable<RollSpec> rss = ParseStr(rollStr);
      for (final rs in rss) {
        res += Roll(rs);
      }
    }
    return res;
  }

  int Roll(RollSpec rs) {
    var rnd = Random();
    List<int> values = List<int>.filled(rs.nDice, 0);
    int result = 0;
    do {
      for (int c = 0; c < rs.nDice; ++c) {
        values[c] = rnd.nextInt(rs.die) + 1;
        if (values[c] <= rs.reroll) values[c] = rnd.nextInt(rs.die) + 1;
      }
      print(values);
      values.sort();
      result = values
              .sublist(rs.dropDice)
              .reduce((value, element) => value + element) +
          rs.bonus;
    } while (result < rs.minTotal);
    return result;
  }
}
