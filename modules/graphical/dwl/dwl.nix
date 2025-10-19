{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (_self: super: {
      dwl =
        (super.dwl.override {
          #  configH = ./dwl-config.h;
        }).overrideAttrs
          (oldAttrs: rec {
            src = inputs.dwl-source;
            enableXWayland = true;
            nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
              pkgs.wlroots
            ];
            buildInputs = oldAttrs.buildInputs ++ [
              pkgs.fcft
              pkgs.libdrm
              pkgs.wlroots
            ];
            patches = [
              #  ./patches/bar.patch
              #  ./patches/swallow.patch
              #  ./patches/config.patch
            ];
          });
    })
  ];
}
