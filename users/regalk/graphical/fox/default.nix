_:

{
  programs.schizofox = {
    enable = true;

    misc.startPageURL = "about:blank";

    extensions.enableExtraExtensions = true;
    # Disable Dark Reader
    extensions.darkreader.enable = true;

    # Use default firefox ui
    extensions.simplefox.enable = false;
    search = {
      defaultSearchEngine = "DuckDuckGo";
      removeEngines = [
        "Bing"
        "Amazon.com"
        "eBay"
        "Twitter"
        "Wikipedia"
        "LibRedirect"
      ];
    };

    extensions.enableDefaultExtensions = true;

    security = {
      sanitizeOnShutdown.enable = false;
      sandbox.enable = true;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      enableCaptivePortal = true;
    };

    theme = {
      font = "Inter";
      colors = {
        background-darker = "181825";
        background = "1e1e2e";
        foreground = "cdd6f4";
      };
    };

  };
}
