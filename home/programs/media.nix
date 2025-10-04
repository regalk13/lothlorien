{
  pkgs,
  ...
}:
# media - control and enjoy audio/video
{
  # imports = [
  # ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    # images
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
