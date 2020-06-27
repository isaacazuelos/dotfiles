;;; languages.el -- Language-specific configurations
;;; Commentary:
;;; Code:

(use-package flycheck
  :init
  (global-flycheck-mode))

;;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)

;;; English
(use-package flyspell
  :custom
  (flyspell-mode 1))

(use-package ispell)

(provide 'languages)
;;; languages.el ends here
