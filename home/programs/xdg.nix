_:
let
  browser = [ "Schizofox.desktop" ];

  # XDG MIME types
  associations = {
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "audio/*" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "image/*" = [ "imv.desktop" ];
    "application/json" = browser;
    "application/pdf" = [ "sioyek.desktop" ];
  };
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
