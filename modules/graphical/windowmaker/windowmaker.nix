_:
{
  nixpkgs.overlays = [
    (final: prev: {
      windowmaker = prev.windowmaker.overrideAttrs (_oldAttrs: {
        version = "0.96.0-unstable-2026-01-25";

        src = final.fetchgit {
          url = "https://repo.or.cz/wmaker-crm.git";
          rev = "7778df2fc598dfb85d90330fdc6d8c412c94f695";
          hash = "sha256-0Wzw0xYw36/fkliC9kbpfoBAvzYRP8on1xKuufSgQ0k=";
        };
      });
    })
    (_final: prev: {
      dockapps = prev.dockapps // {
        wmCalClock = prev.dockapps.wmCalClock.overrideAttrs (oldAttrs: {
          sourceRoot = "${oldAttrs.src.name}/wmCalClock/Src";

          buildPhase = ''
            runHook preBuild
            cc -std=gnu89 -o wmCalClock wmCalClock.c xutils.c  \
              -I${prev.libX11.dev}/include \
              -I${prev.libXext.dev}/include \
              -I${prev.libXpm.dev}/include \
              -L${prev.libX11}/lib \
              -L${prev.libXext}/lib \
              -L${prev.libXpm}/lib \
              -lX11 -lXext -lXpm -lm
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            install -Dm755 wmCalClock $out/bin/wmCalClock
            install -Dm644 wmCalClock.1 $out/share/man/man1/wmCalClock.1 || true
            runHook postInstall
          '';
        });
      };
    })
  ];
}
