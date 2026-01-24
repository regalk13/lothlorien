{ pkgs, ... }:
let
  slstatus-custom = pkgs.slstatus.override {
    conf = ./slstatus-config.h;
  };
in
{
  imports = [ ./dwl.nix ];

  environment.systemPackages = with pkgs; [
    wmenu
    foot
    dwl
    grim
    slurp
    wl-clipboard
    slstatus-custom
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "wlr" "gtk" ];
      };
    };
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "wlroots"; 
    XDG_SESSION_TYPE = "wayland";
  };

  hardware.graphics = {
    enable = true;
    package = pkgs.mesa;
    enable32Bit = true;

    extraPackages = with pkgs; [
      vulkan-loader
      libva-utils
      libvdpau-va-gl

      glfw
      glew
    ];

    extraPackages32 = with pkgs.driversi686Linux; [
      libvdpau-va-gl
    ];
  };
}
