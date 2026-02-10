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

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
