{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    vscodium
    ripgrep
    htop
    libnotify
    xdg-utils
    graphviz

    # cloud native
    docker-compose
    kubectl

    yarn

    thunderbird
    postman
    sioyek
    zathura
  ];
  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "mouse on";
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    aria2.enable = true;

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };

  services.gnome-keyring.enable = true;

  programs.gpg = {
    enable = true;
    mutableKeys = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  services = {
    udiskie.enable = true;
  };
}
