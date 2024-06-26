{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    cd = "z";
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    tree = "tre";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookie -v";
    neofetch = "disfetch";
    fetch = "disfetch";
    gitfetch = "onefetch";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
    z { z "$@" && eza ; }
    autoload -U promptinit; promptinit
    prompt pure
    # PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
    #  %F{green}→%f "
    # RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
    # [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  programs.zoxide.enable = true;
  programs.atuin = {
    enable = true;
    settings = {
      style = "compact";
      enter_accept = true;
      search_mode = "fuzzy";
      exit_mode = "return-query";
      keymap_mode = "vim-insert";
      keymap_cursor = { 
        emacs = "blink-block";
        vim_insert = "steady-underline";
        vim_normal = "steady-block"; 
      };
    };
  };

  home.packages = with pkgs; [
    pure-prompt

    disfetch onefetch
    gnugrep gnused

    bc
    eza # better ls
    bat # better cat
    tre-command # better tree
    fd # find files by name
    
    bottom
    
    direnv
    nix-direnv
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
