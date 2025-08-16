{ pkgs, lib, ... }:

let
  # Still need fix !
  # 为了不使用默认的 rime-data，改用我自定义的小鹤音形数据，这里需要 override
  rime-data-flypy = pkgs.stdenvNoCC.mkDerivation {
    pname = "rime-data-flypy";
    version = "unstable";
    src = ./rime-data-flypy;
    dontBuild = true;
    installPhase = ''
      set -euo pipefail
      dst="$out/share/rime-data"
      mkdir -p "$dst"
      if [ -d "$src/share/rime-data" ]; then
        cp -r "$src"/share/rime-data/* "$dst"/
      else
        cp -r "$src"/* "$dst"/
      fi
    '';
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      rime-data-flypy = rime-data-flypy;
      fcitx5-rime = prev.fcitx5-rime.override {
        rimeDataPkgs = [ prev.rime-data rime-data-flypy ];
      };
    })
  ];
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-gtk
    ];
  };
}
