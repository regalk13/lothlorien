{ ... }:
{
  imports = [
    ../../home/core.nix
    ../../home/programs
    ../../home/shell
    ../../home/doom-emacs
    ./graphical/fcitx5
    ./graphical/fox
    ./graphical/mangowc
    ./graphical/waybar
  ];

  programs.git.settings = {
    user = {
      name = "Regalk";
      email = "72028266+regalk13@users.noreply.github.com";
    };
  };
}
