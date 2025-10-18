{ pkgs, ... }:
{
    imports = [ ./qemu.nix ];

    environment.systemPackages = with pkgs; [
        qemu
        libvirt
        virt-manager
    ];   

    virtualisation.libvirtd = {
        enable = true;
    };
}