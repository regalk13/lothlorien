{
  pkgs,
  runCommand,
  emacsPackagesFor,
  emacs30-pgtk,
  makeWrapper,

  # Color scheme
  callPackage,
  colorScheme,
}:
let
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
      (callPackage ./theme.nix { inherit colorScheme; })

      # Keybinds
      evil
      evil-collection
      # which-key
      general
      hydra

      # IDE
      lsp-mode
      lsp-ui
      # lsp-treemacs
      lsp-ivy
      company
      company-box
      undo-tree
      evil-nerd-commenter
      direnv

      # Languages
      typescript-mode
      nix-mode
      markdown-mode
      # rust!
      #rust-mode
      #cargo

      # Note-taking
      org
      org-roam
      org-roam-ui
      visual-fill-column
      math-preview
      pkgs.math-preview

      # Other
      no-littering
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
