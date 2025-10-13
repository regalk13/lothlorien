{ pkgs, ... }:
{
  imports = [ ./dwl.nix ];

  environment.systemPackages = with pkgs; [
    wmenu
    foot
    dwl
    grim
    slurp
    wl-clipboard
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  hardware.opengl.enable = true;
  hardware.graphics = {
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
