_:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      ################
      ### MONITORS ###
      ################

      # See https://wiki.hyprland.org/Configuring/Monitors/

      monitor=,1920x1080@75,auto,auto

      env = HYPRCURSOR_THEME,macOS
      env = HYPRCURSOR_SIZE,40
      exec-once = hyprctl setcursor macOS 28
      exec-once = qs
    '';
  };
}
