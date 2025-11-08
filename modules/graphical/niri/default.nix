{ pkgs, ... }:
{
  programs.niri.enable = true;
  # programs.waybar.enable = true;

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    xwayland-satellite
    nautilus
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screencast" = [ "gnome" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
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
