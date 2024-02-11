# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:
{
  imports =
    [ ../work/configuration.nix # Personal is essentially work system + games
      #../../system/hardware/openrgb.nix
      ../../system/app/gamemode.nix
      ../../system/app/steam.nix
      ../../system/app/prismlauncher.nix
    ];
}
