{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  secureBootOVMF = pkgs.OVMF.override {
    secureBoot = true;
    # msVarsTemplate = true;
    tpmSupport = true;
    tlsSupport = true;
  };
in {
  imports = [
    ./qemu
  ];

  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.br0.useDHCP = true;
  networking.bridges = {
    "br0" = {
      interfaces = ["eth0"];
    };
  };

  security.sudo.extraRules = [
    {
      groups = ["libvirtd"];
      commands = [
        {
          command = "/run/current-system/sw/bin/ddcutil -d 2 setvcp 60 0x0f";
          options = ["SETENV" "NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/ddcutil -d 2 setvcp 60 0x11";
          options = ["SETENV" "NOPASSWD"];
        }
      ];
    }
  ];

  virtualisation.libvirtd.qemu = {
    runAsRoot = true;
    swtpm.enable = true;
    verbatimConfig = ''
      nvram = [
        "/run/libvirt/nix-ovmf/edk2-x86_64-secure-code.fd:/run/libvirt/nix-ovmf/edk2-x86_64-secure-code.fd"
      ]
    '';
  };

  users.groups.libvirt.members = ["root" "regalk"];
  users.groups.libvirtd.members = ["root" "regalk"];
  users.groups.kvm.members = ["root" "regalk"];

  environment.systemPackages = with pkgs; [
    python313Packages.virt-firmware
  ];
}