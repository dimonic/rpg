import 'dart:math';

class RollSpec {
    RollSpec({int this.n_dice = 1, int this.die = 6, int this.reroll = 0, int this.drop_dice = 0, int this.bonus = 0, int this.min_total = 1}) {}
    int n_dice;
    int die;
    int reroll;
    int drop_dice;
    int bonus;
    int min_total;
}

mixin Roller {
    /** \brief Roll dice based on str <ndice> d <die> [r reroll k keep +- bonus]
    */
    int RollStr(String roll_str)
    {
        RollSpec rs = RollSpec();
        if (roll_str.length != 0) {
            RegExp roll_expr = RegExp(r'\s*(\d+)?\s*([dD])\s*(\d+)\s*(.*)?');
            RegExpMatch? matches = roll_expr.firstMatch(roll_str);
            if (matches == null) {
                print("I don't understand the die-roll expression: ${roll_str}");
                return 0;
            }
            var match = matches!;
            if (match.group(1) != null)
                rs.n_dice = int.parse(match.group(1)!);
            rs.die = int.parse(match.group(3)!);
            if (match.group(4) != null) {
                RegExp mod_expr = RegExp(r'\s*([rRkK+-])\s*(\d+)');
                Iterable<RegExpMatch> mods = mod_expr.allMatches(match.group(4)!);
                for (final mod in mods) {
                    int value = int.parse(mod.group(2)!);
                    switch (mod.group(1)) {
                        case 'r':
                        case 'R': {
                            rs.reroll = value;
                        }
                        break;
                        case 'k':
                        case 'K': {
                            rs.drop_dice = rs.n_dice - value;
                        }
                        break;
                        case '+': {
                            rs.bonus = value;
                        }
                        break;
                        case '-': {
                            rs.bonus = -value;
                        }
                        break;
                    }
                }
            }
        }
        return Roll(rs);
    }

    int Roll(RollSpec rs) {
        var rnd = Random();
        List<int> values = List<int>.filled(rs.n_dice, 0);
        int result = 0;
        do {
            for (int c = 0; c < rs.n_dice; ++c) {
                values[c] = rnd.nextInt(rs.die) + 1;
                if (values[c] <= rs.reroll)
                    values[c] = rnd.nextInt(rs.die) + 1;
            }
            print(values);
            values.sort();
            result = values.sublist(rs.drop_dice).reduce((value, element) => value + element) + rs.bonus;
        } while (result < rs.min_total);
        return result;
    }
}