{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
    ];
    extraPackages = with pkgs; [ ];
  };
}