# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:
{
  imports =
    [ ../personal/configuration.nix # virtualbox is essentially personal + utils and driver support
    ];

  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;
  };

}
