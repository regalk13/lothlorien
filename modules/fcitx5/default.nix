{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      settings.addons.clipboard.globalSection.Enabled = "False";
      addons = with pkgs; [
        catppuccin-fcitx5
        (fcitx5-rime.override {
          rimeDataPkgs = [
            rime-ice
            fcitx5-pinyin-zhwiki
            rime-data
          ];
        })
      ];
    };
  };
}
