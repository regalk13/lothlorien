{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 20;

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
        format = "⏻";
        "on-click" = "nwgbar";
        tooltip = false;
      };
    };
    style = ''
               * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
      }

      window#waybar {
          background-color: #82949e;
          color: #4a5353;
          border: 2px solid #4a5353;
          box-shadow: inset -2px 2px 0 0px #a1acae, inset 2px -2px 0px 0px #687677;
      }

      #custom-firefox,
      #custom-anki,
      #custom-power,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio {
      background-color: #b3b5b2;
      margin-left: 4px;
      margin-right: 4px;
      margin-top: 2px;
      margin-bottom: 2px;
      padding-top: 2px;
      padding-bottom: 2px;
      border: 1px solid #4a5353;
      box-shadow: inset 2px -2px 0px 0px #cccac2, inset -2px 2px 0px 0px #e5dfd3;
      }

      #custom-firefox, #custom-anki, #battery, #network, #pulseaudio {
      font-size: 16px;
      }

      #custom-power {
      margin-top: 4px;
      }

      #battery {
      margin-bottom: 4px;
      }

      #cpu {
      border-bottom: none;
      margin-bottom: -2px;
      box-shadow: inset 2px 0px 0px 0px #cccac2, inset -2px 2px 0px 0px #e5dfd3;
      }

      #memory {
      margin-top: -2px;
      border-top: none;
      box-shadow: inset 2px -2px 0px 0px #cccac2, inset -2px 0px 0px 0px #e5dfd3;
      }

      #pulseaudio.microphone {
      border-bottom: none;
      margin-top: 2px;
      margin-bottom: -2px;
      border: 1px solid #4a5353;
      border-bottom: none;
      box-shadow: inset 2px -2px 0px 0px #cccac2, inset -2px 2px 0px 0px #e5dfd3;
      }

      #pulseaudio {
      margin-top: -4px;
      border-top: none;
      box-shadow: inset 2px -2px 0px 0px #cccac2, inset -2px 0px 0px 0px #e5dfd3;
      }
    '';
  };
}
