{
  description = "NixOS configuration of Regalk";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # neovim-nightly-overlay = {
    #  url = "github:nix-community/neovim-nightly-overlay";
    # };

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    hyprland.url = "github:hyprwm/Hyprland";

    digital-logic-sim = {
      url = "github:regalk13/digital-logic-sim-flake";
    };

    disko = {
      url = "github:nix-community/disko";
    };
    
    agenix = {
      url = "github:ryantm/agenix";
    };

    # quickshell = {
    #  url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    
    schizofox.url = "github:schizofox/schizofox";
    
    dwl-source = {
      url = "github:djpohly/dwl";
      flake = false;
    };
  };

  outputs =
    {
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./formatter.nix
        ./hosts
      ];

      systems = [
        "x86_64-linux"
      ];
    };
}
