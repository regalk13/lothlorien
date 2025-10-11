{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pavucontrol
    playerctl
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
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
