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
}
