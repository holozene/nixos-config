{ config, lib, pkgs, systemSettings, ... }:

{
  # Module installing neovim
  home.packages = [ pkgs.vim pkgs.neovim ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # load an alternate keymap in init.vim (nix doesn't support lua config)
    configure.customRC = if (systemSettings.keymap == "qgmlwy") then
      ''
        noremap k a
        noremap j o

        noremap a h
        noremap o j
        noremap e k
        noremap h l

        noremap l $

        inoremap hh <esc>
        vnoremap ' <esc>
      ''
    else 
      ''
        inoremap jj <esc>
        vnoremap ' <esc>
      '';

    configure.packages.myVimPackage = with pkgs.vimPlugins; {
      # loaded on launch
      start = [
        telescope-nvim
        # yankring-vim
        vim-nix # nix support
        vim-nixhash # automatic nix hash string replacement
      ];
      # manually loadable by calling `:packadd $plugin-name`
      opt = [ ];
    };
  };

}

# Keymap in lua (for use in init.lua if nixpkgs ever supports it)
# [or for use in extraLuaConfig with home manager]
# [or I write a writeText method to do it myself]
# -- Keymap
# local function map(lhs, rhs)
#     vim.api.nvim_set_keymap("", lhs, rhs, { noremap = true })
# end

# local function mapMode(mode, lhs, rhs)
#     vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
# end

# map("k", "a")
# map("j", "o")

# map("a", "h")
# map("o", "j")
# map("e", "k")
# map("h", "l")

# map("l", "$")

# mapMode("i", "hh", "<esc>")
# mapMode("v", "/'", "<esc>")