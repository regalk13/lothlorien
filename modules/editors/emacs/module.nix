{
  lib,
  pkgs,
  config,
  ...
}:

let
  emacsDrv = pkgs.callPackage ./emacs.nix {};
in
{
  options.regalk.emacs.enable = lib.mkEnableOption "Regalk’s custom Emacs";

  config = lib.mkIf config.regalk.emacs.enable {
    environment.systemPackages = [ emacsDrv ];

    services.emacs = {
      enable = true;
      package = emacsDrv;
    };
  };
}
