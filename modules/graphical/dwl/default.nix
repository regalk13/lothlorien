{ pkgs, ... }:
{
    imports = [./dwl.nix];

    environment.systemPackages =
    with pkgs;
    [
        foot
        dwl
        grim
        slurp
        wl-clipboard
    ];

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    xdg.portal.enable = true;
    
    xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-wlr
    ];

    hardware.graphics = {
        package = pkgs.mesa;
        enable32Bit = true;
    };
}