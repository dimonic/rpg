import 'dart:math';


mixin Roller {
    /** \brief Roll dice based on str <ndice> d <die> [r reroll k keep +- bonus]
    */
    int RollStr(String roll_str)
    {
        int n_dice = 1;
        int die = 6;
        int reroll = 0;
        int drop_dice = 0;
        int bonus = 0;
        RegExp roll_expr = RegExp(r'\s*(\d+)?\s*([dD])\s*(\d+)\s*(.*)?');
        RegExpMatch? matches = roll_expr.firstMatch(roll_str);
        if (matches == null) {
            print("I don't understand the die-roll expression: ${roll_str}");
            return 0;
        }
        var match = matches!;
        if (match.group(1) != null)
            n_dice = int.parse(match.group(1)!);
        die = int.parse(match.group(3)!);
        if (match.group(4) != null) {
            RegExp mod_expr = RegExp(r'\s*([rRkK+-])\s*(\d+)');
            Iterable<RegExpMatch> mods = mod_expr.allMatches(match.group(4)!);
            for (final mod in mods) {
                int value = int.parse(mod.group(2)!);
                switch (mod.group(1)) {
                    case 'r':
                    case 'R': {
                        reroll = value;
                    }
                    break;
                    case 'k':
                    case 'K': {
                        drop_dice = n_dice - value;
                    }
                    break;
                    case '+': {
                        bonus = value;
                    }
                    break;
                    case '-': {
                        bonus = -value;
                    }
                    break;
                }
            }
        }
        return Roll(die, n_dice, reroll, bonus, drop_dice);
    }

    int Roll(int die, int n_dice, [int reroll = 0, int bonus = 0, int d_dice = 0, int min_total = 1]) {
        var rnd = Random();
        List<int> values = List<int>.filled(n_dice, 0);
        int result = 0;
        do {
            for (int c = 0; c < n_dice; ++c) {
                values[c] = rnd.nextInt(die) + 1;
                if (reroll != 0 && values[c] == reroll)
                    values[c] = rnd.nextInt(die) + 1;
            }
            print(values);
            values.sort();
            result = values.sublist(d_dice).reduce((value, element) => value + element) + bonus;
        } while (result < min_total);
        return result;
    }
}