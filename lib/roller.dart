import 'dart:math';

class RollSpec {
  RollSpec(
      {this.nDice = 1,
      this.die = 6,
      this.reroll = 0,
      this.dropDice = 0,
      this.bonus = 0,
      this.minTotal = 1});
  int nDice;
  int die;
  int reroll;
  int dropDice;
  int bonus;
  int minTotal;
}

mixin Roller {
  RollSpec? parseDieExpr(String dieStr) {
    RollSpec rs = RollSpec();
    RegExp rollExpr = RegExp(r'\s*(\d+)?([dD])(\d+)([^\s]*)?');
    final matchIf = rollExpr.firstMatch(dieStr);
    if (matchIf == null) {
      return null;
    }
    RegExpMatch match = matchIf;
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
          case 'r': // reroll die values this or under
          case 'R':
            {
              rs.reroll = value;
            }
            break;
          case 'k': // keep this many dice
          case 'K':
            {
              rs.dropDice = rs.nDice - value;
            }
            break;
          case '+': // add this bonus to total die roll
            {
              rs.bonus = value;
            }
            break;
          case '-': // or subtract this
            {
              rs.bonus = -value;
            }
            break;
        }
      }
    }
    return rs;
  }

  Iterable<RollSpec> parseStr(String rollStr) {
    List<RollSpec> rss = <RollSpec>[];
    RollSpec? rs;
    RegExp rollExpr = RegExp(r'\s*([^\s]*)(\s+\+)?');
    Iterable<RegExpMatch> matches = rollExpr.allMatches(rollStr);
    for (final match in matches) {
      print(match.input.substring(match.start, match.end));
      rs = parseDieExpr(match.input.substring(match.start, match.end));
      if (rs != null) rss.add(rs);
    }
    return rss;
  }

  /// \brief roll dice based on str <ndice> d <die> [r reroll k keep +- bonus]
  int RollStr(String rollStr) {
    int res = 0;
    if (rollStr.isEmpty) {
      res = roll(RollSpec());
    } else {
      Iterable<RollSpec> rss = parseStr(rollStr);
      for (final rs in rss) {
        res += roll(rs);
      }
    }
    return res;
  }

  int roll(RollSpec rs) {
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
    print(result);
    return result;
  }
}
