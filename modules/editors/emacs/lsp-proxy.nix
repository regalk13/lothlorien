{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "lsp-proxy";
  version = "0.5.7";

  src = fetchFromGitHub {
    owner = "jadestrong";
    repo = "lsp-proxy";
    rev = "v0.5.7";
    sha256 = "sha256-xGKmyQ9uCzxbSLetOYZatHSDRUCS2Gb8UwJZ1k1nZ0M=";
  };

  cargoHash = "sha256-GcnNZGSwg3g5EX2M+2Bz7SIUVR5IitaQf+KjcHbbzzU=";

  installPhase = ''
    runHook preInstall
    install -Dm755 target/x86_64-unknown-linux-gnu/release/emacs-lsp-proxy $out/bin/emacs-lsp-proxy
    install -Dm644 lsp-proxy.el $out/share/emacs/site-lisp/lsp-proxy.el
    runHook postInstall
  '';

  meta = with lib; {
    description = "An LSP client for Emacs, implemented in Rust";
    homepage = "https://github.com/jadestrong/lsp-proxy";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
