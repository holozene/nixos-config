{ config, pkgs, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [ ../personal/home.nix # Personal is essentially work system + games
            ];

  home.packages = with pkgs; [
    # Core
    zsh
    alacritty
    firefox
    dmenu
    rofi
    git
  ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

}
