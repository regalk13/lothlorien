{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (_self: super: {
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        enableXWayland = true;
        buildInputs = oldAttrs.buildInputs ++ [
          pkgs.fcft
          pkgs.libdrm
        ];
        patches = [
          ./patches/bar.patch
         # ./patches/monitorconfig.patch
        ];
        configH = ./dwl-config.h;
      });
    })
  ];
}
