{ ... }:
{
  imports = [
    ../../home/core.nix
    ../../home/programs
    ../../home/shell
    ./graphical/fcitx5
    ./graphical/fox
  ];

  programs.git = {
    userName = "Regalk";
    userEmail = "72028266+regalk13@users.noreply.github.com";
  };
}
