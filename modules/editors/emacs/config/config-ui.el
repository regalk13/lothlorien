;; === Fonts ===
(set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 160)
(set-face-attribute 'fixed-pitch nil :font "Iosevka Nerd Font" :height 100)
(set-face-attribute 'variable-pitch nil :font "Iosevka Nerd Font" :height 120 :weight 'regular)

;; === Theme ===
;; (require 'base16-nix-colors-theme)
;; (setq base16-theme-256-color-source 'colors)
;; (load-theme 'base16-nix-colors t)

;; === Modeline ===
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 28)))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

(load-theme 'gruber-darker :no-confirm)

(provide 'config-ui)
