{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    tetrio-desktop
  ];
}
