{
  lib,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types) enum nullOr;
in
{
  options.hm.programs.defaults = {
    terminal = mkOption {
      type = enum [
        "alacritty"
        "kitty"
        "ghostty"
      ];
      default = "ghostty";
    };

    browser = mkOption {
      type = enum [
        "firefox"
        "chromium"
        "librewolf"
      ];
      default = "firefox";
    };

    editor = mkOption {
      type = enum [
        "vim"
        "codium"
      ];
      default = "vim";
    };

    launcher = mkOption {
      type = nullOr (enum [
        "rofi"
        "wofi"
      ]);
      default = "rofi";
    };
  };
}
