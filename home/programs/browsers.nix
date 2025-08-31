{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=TouchpadOverscrollHistoryNavigation" ];
      extensions = [
        # {id = "";}  // extension id, query from chrome web store
      ];
    };
  };

  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
