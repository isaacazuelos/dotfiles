;;; languages.el -- Language-specific configuration
;;; Commentary:
;;; Code:

;;; Multi-language packages
(add-hook 'prog-mode-hook #'linum-mode)
(electric-pair-mode t)

(use-package company
  :config
  (global-company-mode t))

;;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)

(use-package rainbow-delimiters
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; Ledger
(use-package ledger-mode)

;; nix
(use-package nix-mode)

(provide 'languages)
;;; languages.el ends here
