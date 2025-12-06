{ pkgs, ... }:

let
  emacspkg = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.treesit-grammars.with-all-grammars
    ]);
in
{
  home.packages = with pkgs; [
    emacspkg
    git
    ripgrep
    fd

    imagemagick
    zstd
    sqlite
    editorconfig-core-c
  ];
  services.emacs = {
    enable = true;
    package = emacspkg;
  };
}
