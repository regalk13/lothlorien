{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.treesit-grammars.with-all-grammars
    ]))

    git
    ripgrep
    fd

    imagemagick
    zstd
    sqlite
    editorconfig-core-c
  ];
}
