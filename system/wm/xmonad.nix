{ ... }:

{
  # import X11 config
  imports = [ ./x11.nix ];

  # Setup XMonad
  services.xserver = {
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    displayManager = {
      defaultSession = "none+xmonad";
    };
  };
}
