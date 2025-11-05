{ pkgs, ... }:
{
  programs.niri.enable = true;

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
