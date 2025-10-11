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

    hardware.graphics = {
        package = pkgs.mesa;
        enable32Bit = true;
    };
}