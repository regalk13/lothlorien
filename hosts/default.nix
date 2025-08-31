{ inputs, self, ... }:
let
  mkHost = import ./lib/mkHost.nix {
    inherit inputs self;
    inherit (inputs.nixpkgs) lib;
  };
in
{
  flake.nixosConfigurations = {
    morion = mkHost {
      name = "morion";
      system = "x86_64-linux";
      desktop = true;
      extraImports = [
        inputs.spicetify-nix.nixosModules.default
        ../modules/graphical/hyprland.nix
        ../modules/cli/tools.nix
        ../modules/core
        ../modules/core/locale.nix
        ../modules/desktop/apps.nix
        ../modules/desktop/fonts.nix
        ../modules/desktop/digital-logic-sim.nix
        ../modules/desktop/spotify.nix
        ../modules/networking/firewall.nix
        ../modules/networking/ssh.nix
        ../modules/hardware/audio.nix
        ../modules/hardware/sensors.nix
        ../modules/fcitx5/default.nix
      ];
    };
    gwaeron = mkHost {
      name = "gwaeron";
      system = "x86_64-linux";
      desktop = true;
      extraImports = [
        ../modules/graphical/hyprland.nix
        ../modules/cli/tools.nix
        ../modules/core
        ../modules/core/locale.nix
        ../modules/desktop/apps.nix
        ../modules/desktop/fonts.nix
        ../modules/networking/firewall.nix
        ../modules/networking/ssh.nix
        ../modules/hardware/audio.nix
        ../modules/hardware/sensors.nix
        ../modules/networking/jellyfin.nix
      ];
    };
    osto-lomi = mkHost {
      name = "osto-lomi";
      desktop = false;
      system = "x86_64-linux";
      extraImports = [
        ../modules/cli/tools.nix
        ../modules/core
        inputs.regalk-website.nixosModules.default
        inputs.agenix.nixosModules.default
        ../modules/server
      ];
    };
  };
}
