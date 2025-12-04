{
  pkgs,
  runCommand,
  emacsPackagesFor,
  emacs30-pgtk,
  makeWrapper,
}:
let

  tree-sitter-qmljs = pkgs.tree-sitter.buildGrammar {
    language = "tree-sitter-qmljs";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "yuja";
      repo = "tree-sitter-qmljs";
      rev = "6d4db242185721e1f5ef21fde613ca90c743ec47";
      sha256 = "S6rBQRecJvPgyWq1iydFZgDyXbm9CZBw8kxzNI0cqdw=";
    };
  };

  # lsp-proxy = callPackage ./lsp-proxy.nix { };
  emacsPackage = (emacsPackagesFor emacs30-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      # Use-package
      use-package

      # Completion
      ivy
      ivy-rich
      counsel
      swiper
      helpful
      elisp-refs

      # UI
      all-the-icons
      doom-modeline
      # (callPackage ./theme.nix { inherit colorScheme; })
      # modus-themes
      gruber-darker-theme
      ef-themes

      # Keybinds
      evil
      evil-collection
      # which-key
      general
      hydra

      # IDE
      # lsp-mode
      # lsp-ui
      yasnippet
      lsp-bridge
      # lsp-treemacs
      # lsp-ivy

      # lsp-proxy
      #corfu
      #eglot
      #ht
      #lsp-proxy

      company
      company-box
      undo-tree
      evil-nerd-commenter
      direnv

      # Languages
      typescript-mode
      nix-ts-mode
      markdown-mode
      qml-mode
      # rust!
      rust-mode
      cargo
      emmet-mode

      # qml-ts-mode

      # Note-taking
      org
      org-roam
      org-roam-ui
      visual-fill-column
      math-preview
      pkgs.math-preview

      # Other
      no-littering

      # Chinese
      rime

      elfeed

      pdf-tools

      # treesitter
      tree-sitter
      tree-sitter-langs
      (treesit-grammars.with-grammars (
        grammars: with grammars; [
          tree-sitter-bash
          tree-sitter-rust
          tree-sitter-toml
          tree-sitter-nix
          tree-sitter-html
          tree-sitter-typescript
          tree-sitter-qmljs
        ]
      ))
    ]
  );
in
runCommand "emacs-config"
  {
    nativeBuildInputs = [ makeWrapper ];
    meta.mainProgram = "emacs";
  }
  ''
    # -s will symlink, ensuring emacsPackage is not gc-ed
    cp -rs ${emacsPackage} $out
    chmod -R a+w $out/* # give wrapProgram the required permissions
    wrapProgram $out/bin/emacs \
        --add-flags "--init-directory=${./.}"

    wrapProgram $out/bin/emacsclient \
        --add-flags "--create-frame --alternate-editor="
  ''
