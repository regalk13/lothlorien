_: {
   nixpkgs.overlays = [
    (import ./overlays/rapidocr-overlay.nix)
  ];
  services.open-webui.enable = true;
}
