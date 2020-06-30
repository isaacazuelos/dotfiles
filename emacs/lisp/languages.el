;;; languages.el -- Language-specific configuration
;;; Commentary:
;;; Code:

;;; Multi-language packages
(electric-pair-mode t)

(use-package company
  :delight
  :config
  (global-company-mode t))

;;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
(require 'delight)
(delight 'emacs-lisp-mode "Elisp" :major)
(delight 'eldoc-mode nil "eldoc")

(use-package rainbow-delimiters
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; Ledger
(use-package ledger-mode
  :delight "Ledger")

;; Nix 
(use-package nix-mode
  :delight "Nix")

(provide 'languages)
;;; languages.el ends here
