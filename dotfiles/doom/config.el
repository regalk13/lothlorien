;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(add-to-list 'custom-theme-load-path "~/.config/doom/themes/")
(load-theme 'compline t)

;; Maintain terminal transparency in Doom Emacs
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Org Roam setup
(use-package! org-roam
  :defer t
  :commands (org-roam-node-find
             org-roam-node-insert
             org-roam-dailies-goto-today
             org-roam-buffer-toggle
             org-roam-db-sync
             org-roam-capture)  ; Add this
  :init
  (setq org-roam-directory "~/org/roam"
        org-roam-database-connector 'sqlite-builtin
        org-roam-db-location (expand-file-name "org-roam.db" org-roam-directory)
        org-roam-v2-ack t)

  :config
  ;; Don't sync on startup, only when explicitly needed
  (setq org-roam-db-update-on-save nil)

  ;; Create directory if needed
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t))

  ;; Only enable autosync AFTER first use
  (add-hook 'org-roam-find-file-hook
            (lambda ()
              (unless org-roam-db-autosync-mode
                (org-roam-db-autosync-mode 1))))

  ;; CAPTURE TEMPLATES - Human readable filenames
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: \n\n")
           :unnarrowed t)

          ("c" "concept" plain "%?"
           :target (file+head "concepts/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :concept:\n\n")
           :unnarrowed t)

          ("C" "Contact" plain
          "* Contact Info
:PROPERTIES:
:EMAIL: %^{Email}
:PHONE: %^{Phone}
:BIRTHDAY: %^{Birthday (YYYY-MM-DD +1y)}t
:LOCATION: %^{Location}
:LAST_CONTACTED: %U
:END:

 ** Communications

 ** Notes
 %?"
 :target (file+head "contacts/${slug}.org"
 "#+title: ${title}
 #+filetags: %^{Tags}
 #+created: %U
 ")
 :unnarrowed t)


          ("b" "book" plain "%?"
           :target (file+head "books/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+author: \n#+filetags: :book:\n\n* Summary\n\n* Key Ideas\n\n* Quotes\n\n* Related\n\n")
           :unnarrowed t)

          ("p" "person" plain "%?"
           :target (file+head "people/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :person:\n\n* Background\n\n* Key Ideas\n\n* Works\n\n")
           :unnarrowed t)

          ("t" "tech" plain "%?"
           :target (file+head "tech/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :tech:\n\n")
           :unnarrowed t)

          ("T" "theology" plain "%?"
           :target (file+head "faith/theology/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :theology:faith:\n\n* Doctrine\n\n* Scripture\n\n* Tradition\n\n* Application\n\n")
           :unnarrowed t)

          ("w" "writing" plain "%?"
           :target (file+head "writing/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :writing:draft:\n\n")
           :unnarrowed t)

          ("P" "project" plain "%?"
           :target (file+head "projects/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :project:private:\n\n* Overview\n\n* Goals\n\n* Status\n\n* Notes\n\n")
           :unnarrowed t)))

  ;; DAILIES - Clean date format
  (setq org-roam-dailies-directory "daily/"
        org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%H:%M>: %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: %<%Y-%m-%d %A>\n#+filetags: :daily:\n\n"))))

  ;; Enable completion everywhere (for linking)
  (setq org-roam-completion-everywhere t))

(defun my/elfeed-open-in-mpv ()
  "Open the current Elfeed entry's link in MPV asynchronously."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode)
                   elfeed-show-entry
                 (elfeed-search-selected :ignore-region))))
    (when entry
      (let ((link (elfeed-entry-link entry)))
        (message "Sending to MPV: %s" link)
        (start-process "mpv-process" nil "mpv" link)))))

(make-directory "~/.elfeed" t)

;; Set org feed file
(setq rmh-elfeed-org-files '("~/.config/doom/elfeed.org"))

;; Configure elfeed - consolidate all elfeed config in one after! block
(after! elfeed
  (setq elfeed-db-directory "~/.elfeed")
  (setq elfeed-search-filter "@1-week-ago +unread -4chan -news -Reddit")

  ;; Key bindings
  (map! :map elfeed-search-mode-map
        :n "d" #'elfeed-download-current-entry
        :n "v" #'my/elfeed-open-in-mpv
        :n "O" #'elfeed-search-browse-url))

(run-at-time nil (* 60 60) #'elfeed-update)

(use-package! elfeed-tube
  :after elfeed
  :config
  (elfeed-tube-setup)
  
  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)))
