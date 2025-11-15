{
  description = "NixOS configuration of Regalk";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    digital-logic-sim = {
      url = "github:regalk13/digital-logic-sim-flake";
    };

    disko = {
      url = "github:nix-community/disko";
    };

    agenix = {
      url = "github:ryantm/agenix";
    };

    schizofox.url = "github:regalk13/schizofox";

    dwl-source = {
      url = "github:regalk13/dwl-fork";
      flake = false;
    };

    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/0.6.0";
      inputs.nixpkgs.follows = "nixpkgs";
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
