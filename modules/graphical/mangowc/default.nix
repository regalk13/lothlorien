{ pkgs, ... }:
{
  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    rofi
    foot
    grim
    slurp
    wl-clipboard
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [
          "wlr"
          "gtk"
        ];
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
