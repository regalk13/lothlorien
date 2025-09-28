{ ... }:
{
  imports = [
    ../../home/core.nix
    ../../home/programs
    ../../home/rofi
    ../../home/shell
    ./graphical/hyprland
    ./graphical/quickshell
    ./graphical/hyprpaper
    ./graphical/fcitx5
    ./graphical/fox
  ];

  programs.git = {
    userName = "Regalk";
    userEmail = "72028266+regalk13@users.noreply.github.com";
  };

  programs.hyprland-custom = {
    end4s.enable = true;

    hyprland = {
      monitor = [
        ",1920x1080@75,auto,auto"
      ];
      ozoneWayland.enable = false;
    };
  };
}
