{ pkgs, ... }:

{
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # core
    zoxide # better cd
    eza # better ls
    bat # better cat
    tre-command # better tree
    mdcat # cat markdown
    viu # view images
    chafa # approximate images (very well)
    
    # meta
    progress # check progress of core unix commands
    noti # notify user on command completion
    tealdeer # command guides
    mcfly # terminal history

    # network
    gping # ping with a graph
    wget # download files
    curl # transfer data/files
    rsync # file copy
    aria # download utility
    xh # send http requests
    git 
    gh
    # lazy-git # git tui
    # git-ignore # fetch .gitignore templates from gitignore.io

    # files
    fzf # fuzzy file search
    # skim # fuzzy file search (slower, maybe better defaults)
    fd # find files by name
    ripgrep-all # regex search
    sd # search and replace
    ouch # file compression
    monolith # save whole webpages to disk
    trash-cli # terminal trashcan

    # multimedia
    imagemagick # cli for image processing
    gifsicle # cli for gif processing
    ffmpeg # cli for video processing

    # development
    # just # save and run project-specific commands
    # xxh # bring shell environment with you over ssh
    # tokei # count loc

    # maintenance
    killall
    btop
    bottom # system monitor
    topgrade
    du-dust # tree of large files
    psmisc # process tools
    hwinfo


    # Command Line
    disfetch neofetch onefetch starfetch
    lolcat cowsay
    gnugrep gnused
    libnotify
    timer
    tmux
    
    brightnessctl
    w3m # terminal browser
    cava # audio visualizer
    pandoc
    pciutils

    (pkgs.callPackage ../pkgs/smartcalc.nix { })
    (pkgs.writeShellScriptBin "sc" ''smartcalc'')
    #(pkgs.callPackage ../pkgs/ytsub.nix { })
    #(pkgs.callPackage ../pkgs/russ.nix { })
    #(pkgs.python3Packages.callPackage ../pkgs/impressive.nix { })
    (pkgs.callPackage ../pkgs/pokemon-colorscripts.nix { })
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          nmcli n off
      else
          nmcli n on
      fi
    '')
  ];

  imports = [
    ../bin/phoenix.nix # My nix command wrapper
    ../bin/ytsub-wrappers.nix # My ytsub wrapper
  ];
}
