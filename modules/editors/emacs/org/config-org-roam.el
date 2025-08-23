(use-package org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-M-i"   . completion-at-point))
  :config
  (setq org-roam-directory (file-truename "~/notes/org"))
  (setq org-roam-completion-everywhere t)
  ; (setq find-file-visit-truename t) ;; Resolve symlinks
  (org-roam-db-autosync-mode)
)

(defun my/org-roam-filter-by-tag (tag-name)
  "Return a filter function that checks if a node has TAG-NAME."
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-find-by-tag (tag-name)
  "Find an Org-roam node by TAG-NAME, chosen interactively."
  (interactive
   (list
    (completing-read
     "Tag: "
     (flatten-list
      (org-roam-db-query [:select [tag] :from tags :group-by tag])))))
  (org-roam-node-find nil nil (my/org-roam-filter-by-tag tag-name)))

(use-package org-roam-ui
  :config
  (setq org-roam-ui-sync-theme t)
  (setq org-roam-ui-follow t)
  (setq org-roam-ui-update-on-save t)
  (setq org-roam-ui-open-on-start t)
)

(provide 'config-org-roam)
