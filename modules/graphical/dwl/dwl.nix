{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        enableXWayland = true;
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.fcft pkgs.libdrm ];
        patches = [
            ./patches/bar.patch
        ];
        configH = ./dwl-config.h;
      });
    })
  ];
}
