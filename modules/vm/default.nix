{ pkgs, ... }:

{
  imports = [
    ./libvirt.nix
    ./qemu
    ./kernel.nix
    ./edk2.nix
    ./xml.nix
  ];

  programs = {
    dconf.enable = true;
    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    virtio-win
    win-spice
    looking-glass-client
  ];
}
