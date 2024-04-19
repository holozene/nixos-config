{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    wine
    bottles
    # The following requires 64-bit FL Studio (FL64) to be installed to a bottle
    # With a bottle name of "FL Studio"
    (pkgs.writeShellScriptBin "flstudio" ''
       #!/bin/sh
       if [ -z "$1" ]
         then
           bottles-cli run -b "FL Studio" -p FL64
           #flatpak run --command=bottles-cli com.usebottles.bottles run -b FL\ Studio -p FL64
         else
           filepath=$(winepath --windows "$1")
           echo \'"$filepath"\'
           bottles-cli run -b "FL Studio" -p "FL64" --args \'"$filepath"\'
           #flatpak run --command=bottles-cli com.usebottles.bottles run -b FL\ Studio -p FL64 -args "$filepath"
         fi
    '')
    (pkgs.makeDesktopItem {
      name = "flstudio";
      desktopName = "FL Studio 64";
      exec = "flstudio %U";
      terminal = false;
      type = "Application";
      mimeTypes = ["application/octet-stream"];
    })
  ];

  xdg.mimeApps.associations.added = {
    "application/octet-stream" = "flstudio.desktop;";
  };
}