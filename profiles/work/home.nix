{ config, pkgs, pkgs-kdenlive, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [
              stylix.homeManagerModules.stylix
              ../../user/style/stylix.nix # Styling and themes
              (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix") # window manager selected from flake
              (./. + "../../../user/app/browser"+("/"+userSettings.browser)+".nix") # default browser selected from flake
              (./. + "../../../user/app/editor"+("/"+userSettings.editor)+".nix") # default editor selected from flake
              (./. + "../../../user/app/terminal"+("/"+userSettings.term)+".nix") # default terminal selected from flake
              ../../user/shell/sh.nix # zsh and bash config
              ../../user/shell/cli-collection.nix # Useful CLI apps
              ../../user/app/ranger/ranger.nix # ranger file manager config
              ../../user/app/git/git.nix # git config
              ../../user/app/virtualization/virtualization.nix # Virtual machines
              #../../user/app/flatpak/flatpak.nix # Flatpaks
              ../../user/style/stylix.nix # Styling and themes for my apps
              ../../user/lang/cc/cc.nix # C and C++ tools
              ../../user/hardware/bluetooth.nix # Bluetooth
            ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = (with pkgs; [
    # Core
    zsh
    alacritty
    dmenu
    rofi
    git
    syncthing

    spotify
    youtube-music
    tdesktop # telegram
    vscode

    wine
    bottles

    # Media
    gimp-with-plugins
    pinta # basic paint
    krita # paint
    inkscape # vector
    musikcube
    vlc
    mpv
    yt-dlp
    #freetube

    audio-recorder
    ffmpeg

    # Office
    libreoffice-fresh
    mate.atril # pdf viewer
    openboard
    xournalpp # pdf annotate
    gnome.adwaita-icon-theme
    shared-mime-info
    glib
    newsflash # rss reader
    foliate
    gnome.nautilus
    gnome.gnome-calendar
    gnome.seahorse # keyring manager
    gnome.gnome-maps
    openvpn
    protonmail-bridge
    texliveSmall
    numbat

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

    # Media
    gimp
    pinta
    krita
    inkscape
    musikcube
    vlc
    mpv
    yt-dlp
    blender-hip
    cura
    curaengine_stable
    openscad
    (stdenv.mkDerivation {
      name = "cura-slicer";
      version = "0.0.7";
      src = fetchFromGitHub {
        owner = "Spiritdude";
        repo = "Cura-CLI-Wrapper";
        rev = "ff076db33cfefb770e1824461a6336288f9459c7";
        sha256 = "sha256-BkvdlqUqoTYEJpCCT3Utq+ZBU7g45JZFJjGhFEXPXi4=";
      };
      phases = "installPhase";
      installPhase = ''
        mkdir -p $out $out/bin $out/share $out/share/cura-slicer
        cp $src/cura-slicer $out/bin
        cp $src/settings/fdmprinter.def.json $out/share/cura-slicer
        cp $src/settings/base.ini $out/share/cura-slicer
        sed -i 's+#!/usr/bin/perl+#! /usr/bin/env nix-shell\n#! nix-shell -i perl -p perl538 perl538Packages.JSON+g' $out/bin/cura-slicer
        sed -i 's+/usr/share+/home/${userSettings.username}/.nix-profile/share+g' $out/bin/cura-slicer
      '';
      propagatedBuildInputs = with pkgs; [
        curaengine_stable
      ];
    })
    obs-studio
    ffmpeg
    (pkgs.writeScriptBin "kdenlive-accel" ''
      #!/bin/sh
      DRI_PRIME=0 kdenlive "$1"
    '')
    movit
    mediainfo
    libmediainfo
    mediainfo-gui
    audio-recorder
    gnome.cheese
    ardour
    rosegarden
    tenacity

    # Various dev packages
    texinfo
    libffi
    zlib
    nodePackages.ungit
    ventoy
  ]) ++ ([ pkgs-kdenlive.kdenlive ]);

  services.syncthing.enable = true;

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Projects";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

}
