{ pkgs, ... }:
let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      dvisvgm
      dvipng
      wrapfig
      amsmath
      ulem
      hyperref
      capt-of
      apa7
      collection-fontsrecommended
      scalerel
      scheme-medium
      pgf
      threeparttable
      endfloat
      biblatex
      biblatex-apa
      ;
  };
in
{
  home.packages = with pkgs; [
    tex
  ];
}
