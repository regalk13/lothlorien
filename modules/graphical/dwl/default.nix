{ pkgs, ... }:
{
    imports = [./dwl.nix];

    environment.systemPackages =
    with pkgs;
    [
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
        config = {
        common = {
            default = [ "wlr" ];
        };
        pinnacle = {
            default = [ "wlr" ];
            "org.freedesktop.impl.portal.ScreenCast" = "wlr";
            "org.freedesktop.impl.portal.Screenshot" = "wlr";
            "org.freedesktop.impl.portal.Inhibit" = "none";
        };
        };
    };
    hardware.graphics = {
        package = pkgs.mesa;
        enable32Bit = true;
    };
}