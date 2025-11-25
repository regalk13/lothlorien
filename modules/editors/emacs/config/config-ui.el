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


(use-package ef-themes
  :init
  ;; (setq ef-bio-palette-overrides
  ;;       '((bg-main "#131313")))
  (setq ef-dream-palette-overrides
        '((bg-main "#131015")
          (bg-hl-line "#232224")
          (fg-mode-line "#f2ddcf")
          (bg-mode-line "#472b00")
          (yellow-cooler "#ff9f0a")
          ;; (bg-hl-line "#2e1a3a")
          ;; (bg-hl-line "#352102")
          ;; (bg-hl-line "#3b393e")
          ;; (bg-mode-line "#5E4527")
          ))

  :config
  (load-theme 'ef-dream t)
  ;; (load-theme 'ef-winter)
  ;; (load-theme 'ef-trio-dark)
  ;; (load-theme 'ef-spring t)
  ;; (load-theme 'ef-bio t)
  )

;; (load-theme 'gruber-darker :no-confirm)

(provide 'config-ui)
