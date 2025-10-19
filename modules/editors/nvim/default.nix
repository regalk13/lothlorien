{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
      vimAlias = true;
      luaRcContent = builtins.readFile ./init.lua;
      plugins = with pkgs.vimPlugins; [
        gruber-darker-nvim
        oil-nvim
        mini-pick
        nvim-lspconfig
      ];
    })
  ];
}
