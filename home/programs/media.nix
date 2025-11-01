{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pavucontrol
    pulsemixer
    imv
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };

    obs-studio = {
      enable = true;
    };
  };
}
