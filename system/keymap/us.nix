{ config, lib, pkgs, ... }:

{
  services.xserver.xkb.extraLayouts = {
    qgmlwy = {
      description  = "carpalx qgmlwy";
      languages    = [ "eng" ];
      # todo: make sure extension is correct
      symbolsFile = pkgs.writeText "qgmlwy" ''
        partial alphanumeric_keys
        xkb_symbols "qgmlwy" {
          name[Group1]= "English (Qgmlwy)";

          key <TLDE> { [ grave, asciitilde, dead_grave, dead_tilde ] };

          key <AE01> { [ 1, exclam     ] };
          key <AE02> { [ 2, at         ] };
          key <AE03> { [ 3, numbersign ] };
          key <AE04> { [ 4, dollar     ] };
          key <AE05> { [ 5, percent    ] };
          key <AE06> { [ 6, asciicircum, dead_circumflex, dead_circumflex ] };
          key <AE07> { [ 7, ampersand  ] };
          key <AE08> { [ 8, asterisk   ] };
          key <AE09> { [ 9, parenleft,   dead_grave ] };
          key <AE10> { [ 1, parenright ] };
          key <AE11> { [ minus, underscore ] };
          key <AE12> { [ equal, plus   	   ] };

          key <AD01> { [ q, Q ] };
          key <AD02> { [ g, G ] };
          key <AD03> { [ m, M ] };
          key <AD04> { [ l, L ] };
          key <AD05> { [ w, W ] };
          key <AD06> { [ y, Y ] };
          key <AD07> { [ f, F ] };
          key <AD08> { [ u, U ] };
          key <AD09> { [ b, B ] };
          key <AD10> { [ semicolon,    colon,      dead_ogonek, dead_doubleacute ] };
          key <AD11> { [ bracketleft,  braceleft ] };
          key <AD12> { [ bracketright, braceright, dead_tilde] };

          key <AC01> { [ d, D ] };
          key <AC02> { [ s, S ] };
          key <AC03> { [ t, T ] };
          key <AC04> { [ n, N ] };
          key <AC05> { [ r, R ] };
          key <AC06> { [ i, I ] };
          key <AC07> { [ a, A ] };
          key <AC08> { [ e, E ] };
          key <AC09> { [ o, O ] };
          key <AC10> { [ h, H ] };
          key <AC11> { [ apostrophe, quotedbl, dead_acute, dead_diaeresis ] };

          key <AB01> { [ z, Z ] };
          key <AB02> { [ x, X ] };
          key <AB03> { [ c, C ] };
          key <AB04> { [ v, V ] };
          key <AB05> { [ j, J ] };
          key <AB06> { [ k, K ] };
          key <AB07> { [ p, P ] };
          key <AB08> { [ comma,  less,    dead_cedilla,  dead_caron     ] };
          key <AB09> { [ period, greater, dead_abovedot, periodcentered ] };
          key <AB10> { [ slash,  question ] };

          key <BKSL> { [ backslash, bar ] };
        };
      '';
    };
  };
  
  services.xserver.xkb.layout = lib.mkDefault "us";
}
