{ pkgs, ... }:
{
  imports = [ ./dwl.nix ];

  environment.systemPackages = with pkgs; [
    wmenu
    foot
    dwl
    grim
    # slurp
    wl-clipboard
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
  hardware.graphics = {
    package = pkgs.mesa;
    enable32Bit = true;
  };
}
