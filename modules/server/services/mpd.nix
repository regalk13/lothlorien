{ username, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${username}/Music";
    user = "${username}";
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "My PipeWire Output"
      }
    '';
  };

  systemd = {
    services = {
      mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
    };
  };
}
