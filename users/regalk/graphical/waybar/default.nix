{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 15;

      margin-top = 0;
      margin-right = 0;
      margin-bottom = 0;
      margin-left = 0;

      modules-left = [
        "custom/power"
        "tray"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "network"
      ];

      mpd = {
        tooltip = true;
        "tooltip-format" = "{artist} - {album} - {title} - Total Time : {totalTime:%M:%S}";
        format = " {elapsedTime:%M:%S}";
        "format-disconnected" = "⚠  Disconnected";
        "format-stopped" = " Not Playing";
        "on-click" = "mpc toggle";
        "state-icons" = {
          playing = "";
          paused = "";
        };
      };

      "mpd#2" = {
        format = "";
        "format-disconnected" = "";
        "format-paused" = "";
        "format-stopped" = "";
        "on-click" = "mpc -q pause && mpc -q prev && mpc -q start";
      };

      "mpd#3" = {
        interval = 1;
        format = "{stateIcon}";
        "state-icons" = {
          playing = "";
          paused = "";
        };
        "on-click" = "mpc toggle";
      };

      "mpd#4" = {
        format = "";
        "on-click" = "mpc -q pause && mpc -q next && mpc -q start";
      };

      tray = {
        "icon-size" = 14;
        spacing = 5;
      };

      clock = {
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "on-click-right" = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          "on-click-right" = "mode";
          "on-click-forward" = "tz_up";
          "on-click-backward" = "tz_down";
          "on-scroll-up" = "shift_up";
          "on-scroll-down" = "shift_down";
        };
        format = "  {:%a %d %b   %I:%M %p}";
        "format-alt" = "  {:%d/%m/%Y    %H:%M:%S}";
        interval = 1;
      };

      cpu = {
        format = " {usage: >3}%";
        "on-click" = "alacritty -e htop";
      };

      memory = {
        format = " {: >3}%";
        "on-click" = "alacritty -e htop";
      };

      backlight = {
        format = "{icon} {percent: >3}%";
        "format-icons" = [
          ""
          ""
        ];
        "on-scroll-down" = "light -A 5 && light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
        "on-scroll-up" = "light -U 5 && light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity: >3}%";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      network = {
        format = "⚠  Disabled";
        "format-wifi" = "  {essid}";
        "format-ethernet" = "  Wired";
        "format-disconnected" = "⚠  Disconnected";
        "on-click" = "nm-connection-editor";
      };

      "custom/power" = {
        format = "⏻ ";
        "on-click" = "nwgbar";
        tooltip = false;
      };
    };
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: Iosevka Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 14px;
      }

      window#waybar {
          background-color: #181818;
          color: #e4e4ef;
      }

      #custom-firefox,
      #custom-anki,
      #custom-power,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio {
        background-color: #453d41;
        margin-left: 2px;
        margin-right: 2px;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-left: 5px;
        padding-right: 2px;
      }

      #custom-power {
        margin-left: 5px;
        margin-right: 8px;
      }

      #custom-firefox, #custom-anki, #battery, #network, #pulseaudio {
        font-size: 13px;
      }

      #battery {
        margin-bottom: 4px;
      }

      #cpu {
        border-bottom: none;
      }

      #memory {
        border-top: none;
      }

      #pulseaudio.microphone {
        border-bottom: none;
        margin-top: 2px;
        margin-bottom: -2px;
        border-bottom: none;
      }

      #pulseaudio {
        margin-top: -4px;
        border-top: none;
      }
    '';
  };
}
