{ ... }:

{
  # Need some flatpaks
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "*";
  };
}
