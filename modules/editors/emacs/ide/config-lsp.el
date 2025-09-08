(defun os/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(use-package company
	:after lsp-bridge
	:hook (lsp-bridge . company-mode)
	:bind (:map company-active-map
					("<tab>" . company-complete-selection)
					;; ("<return>" . company-complete-selection)
				)
			  (:map lsp-bridge-map
					("<tab>" . company-indent-or-complete-common)
				)
	:custom
	(company-minimum-prefig-length 1)
	(company-idle-delay 0.0)
)

(use-package company-box
	:hook (company-mode . company-box-mode)
)

;; === Undo tree ===
(use-package undo-tree
  :init
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :config
  (global-undo-tree-mode))

;; === Commenting ===
(use-package evil-nerd-commenter
	:bind ("M-#" . evilnc-comment-or-uncomment-lines)
)

;; === Direnv ===
(use-package direnv
  :config
  (direnv-mode))

(provide 'config-lsp)