{ pkgs, ... }:
{
  imports = [ ./windowmaker.nix ];

  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+windowmaker";
    };

    windowManager.windowmaker.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    # Window Maker extras
    dockapps.wmsystemtray
    dockapps.wmcube
    dockapps.wmCalClock
    dockapps.AlsaMixer-app
    dockapps.wmsm-app
    dockapps.cputnik

    # Terminal
    xterm
    alacritty

    # File manager
    pcmanfm

    # Basic X utilities
    xclip
    xsel
    feh
    dmenu
  ];
}
