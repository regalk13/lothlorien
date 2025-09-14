{ inputs, pkgs, ... }:
{

  home.packages = with pkgs; [
    kdePackages.qtdeclarative
    # QuickShell for hyprland
    inputs.quickshell.packages.${pkgs.system}.default
    qt6.qt5compat
  ];

  qt.enable = true;

}
