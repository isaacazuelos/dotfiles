;;; macos.el -- platform specific code
;;;
;;; Commentary:
;;;
;;; I don't actually have a working mac at the moment, so ths is
;;; mostly a hold-over from when I did.
;;;
;;; Code:

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(use-package exec-path-from-shell
  :ensure t
  :init (exec-path-from-shell-initialize))

(provide 'macos)
;;; macos.el ends here
