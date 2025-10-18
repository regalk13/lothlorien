{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (_self: super: {
      qemu =
        (super.qemu).overrideAttrs
          (oldAttrs: rec {
            patches = oldAttrs.patches ++ [
                ./patches/amd-qemu-10.1.0.patch
                ./patches/libnfs6-qemu-10.1.0.patch
            ];
        });
    })
  ];
}
