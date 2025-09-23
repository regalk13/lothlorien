{ pkgs, ... }:
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
  services.getty.autologinUser = "regalk";
  environment.systemPackages = [
    pkgs.mangohud
  ];
}
