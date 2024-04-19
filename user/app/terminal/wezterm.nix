{ config, pkgs, lib, font, ... }:

{
  home.packages = with pkgs; [
    wezterm
  ];
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    return {
      window_background_opacity = 0.75
      hide_tab_bar_if_only_one_tab = true,
      default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
      keys = {
        {key="f", mods="CTRL", action="ToggleFullScreen"},
      }
    }
  ''
}