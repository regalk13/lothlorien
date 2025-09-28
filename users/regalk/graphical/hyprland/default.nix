{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.programs.hyprland-custom;
  
  # Your illogical-impulse-dotfiles input (add this to your flake inputs)
  illogical-impulse-dotfiles = inputs.illogical-impulse-dotfiles or /home/regalk/illogical-impulse-dotfiles;
in
{
  #imports = [
  #  ./extra.nix
  #  ./animations.nix
  #  ./bindings.nix
  #  ./common.nix
  #  ./decorations.nix
  #  ./general.nix
  #];

  options.programs.hyprland-custom = {
    end4s.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable end4s Hyprland configuration instead of default";
    };
    
    hyprland = {
      package = lib.mkOption {
        type = lib.types.package;
        default = null;
        description = "Hyprland package to use";
      };
      
      xdgPortalPackage = lib.mkOption {
        type = lib.types.package;
        default = null;
        description = "XDG portal package to use";
      };
      
      monitor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Monitor configuration";
      };
      
      ozoneWayland.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Ozone Wayland support";
      };
    };
  };

  config = lib.mkMerge [
    # Base configuration - always enable hyprland
    {
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
      };
    }

    # When end4s is enabled, override the default configurations
    (lib.mkIf cfg.end4s.enable {
      home.packages = with pkgs; [
        hyprpicker
        hyprlock
      ];

      wayland.windowManager.hyprland = {
        xwayland.enable = true;
        
        # Use mkForce to completely override settings from other modules
        settings = lib.mkForce {
          "$qsConfig" = "ii";
          
          env = [
            "GIO_EXTRA_MODULES, ${pkgs.gvfs}/lib/gio/modules:$GIO_EXTRA_MODULES"
          ] ++ (lib.optionals cfg.hyprland.ozoneWayland.enable [
            "NIXOS_OZONE_WL, 1"
          ]);
          
          exec = [
            "hyprctl dispatch submap global" # DO NOT REMOVE THIS OR YOU WON'T BE ABLE TO USE ANY KEYBIND
          ];
          
          submap = "global"; # This is required for catchall to work
          debug.disable_logs = false;
          monitor = cfg.hyprland.monitor;
        };
        
        # Override extraConfig from other modules
        extraConfig = lib.mkForce ''
          # Defaults
          source=~/.config/hypr/hyprland/execs.conf
          source=~/.config/hypr/hyprland/general.conf
          source=~/.config/hypr/hyprland/rules.conf
          source=~/.config/hypr/hyprland/colors.conf
          source=~/.config/hypr/hyprland/keybinds.conf
          
          # Custom 
          source=~/.config/hypr/custom/env.conf
          source=~/.config/hypr/custom/execs.conf
          source=~/.config/hypr/custom/general.conf
          source=~/.config/hypr/custom/rules.conf
          source=~/.config/hypr/custom/keybinds.conf
        '';
      };

      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
          };
          listener = [
            {
              timeout = 120;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 600; # 10mins
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 900; # 15mins
              on-timeout = "systemctl suspend || loginctl suspend";
            }
          ];
        };
      };

      xdg.configFile = {
        "hypr/hyprland/scripts".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprland/scripts";
        "hypr/hyprland/execs.conf".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprland/execs.conf";
        "hypr/hyprland/general.conf".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprland/general.conf";
        "hypr/hyprland/rules.conf".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprland/rules.conf";
        "hypr/hyprland/keybinds.conf".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprland/keybinds.conf";
        "hypr/hyprland/colors.conf".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprland/colors.conf";
        "hypr/hyprlock".source = "${illogical-impulse-dotfiles}/.config/hypr/hyprlock";
        "hypr/shaders".source = "${illogical-impulse-dotfiles}/.config/hypr/shaders";
        "hypr/custom".source = "${illogical-impulse-dotfiles}/.config/hypr/custom";
      };
    })
  ];
}