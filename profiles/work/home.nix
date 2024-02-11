{ config, pkgs, nix-doom-emacs, stylix, userSettings, ... }:

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
              ../../user/shell/sh.nix # zsh and bash config
              ../../user/shell/cli-collection.nix # Useful CLI apps
              ../../user/bin/phoenix.nix # nix command wrapper
              (./. + "../../../user/app/browser"+("/"+userSettings.browser)+".nix") # default browser selected from flake
              (./. + "../../../user/app/editor"+("/"+userSettings.editor)+".nix") # default editor selected from flake
              ../../user/app/ranger/ranger.nix # ranger file manager config
              ../../user/app/git/git.nix # git config
              ../../user/app/virtualization/virtualization.nix # Virtual machines
              ../../user/app/flatpak/flatpak.nix # Flatpaks
              ../../user/lang/cc/cc.nix # C and C++ tools
              ../../user/hardware/bluetooth.nix # Bluetooth
            ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Core
    zsh
    alacritty
    dmenu
    rofi
    git
    syncthing

    spotify
    youtube-music
    tdesktop
    vscode

    wine
    bottles

    # Media
    gimp-with-plugins
    pinta
    krita
    inkscape
    musikcube
    vlc
    mpv
    yt-dlp
    #freetube

    audio-recorder
    ffmpeg

    # Office
    libreoffice-fresh
    mate.atril
    xournalpp
    glib
    newsflash
    gnome.nautilus
    gnome.gnome-calendar
    gnome.seahorse
    gnome.gnome-maps
    openvpn
    protonmail-bridge
    texliveSmall

    # Various dev packages
    texinfo
    libffi
    zlib
    nodePackages.ungit
  ];

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
