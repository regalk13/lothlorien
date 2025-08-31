_:

{
  programs.schizofox = {
    enable = true;

    misc.startPageURL = "about:blank";

    search.defaultSearchEngine = "DuckDuckGo";
    extensions.enableExtraExtensions = true;
    # Disable Dark Reader
    extensions.darkreader.enable = true;

    # Use default firefox ui
    extensions.simplefox.enable = true;

    extensions.enableDefaultExtensions = true;
  };
}
