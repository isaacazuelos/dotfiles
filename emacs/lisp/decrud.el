;;; decrud.el -- Emacs init
;;; Commentary:
;;; Code:

(setq
 auto-save-default nil
 custom-file (concat user-emacs-directory "/var/custom-file.el")
 inhibit-startup-echo-area-message t
 inhibit-startup-message t
 inhibit-startup-screen t
 initial-major-mode 'org-mode
 initial-scratch-message nil
 initial-scratch-message nil
 make-backup-files nil
 pop-up-windows nil
 ring-bell-function 'ignore)

(blink-cursor-mode -1)
(column-number-mode t)
(menu-bar-mode -1)
(pixel-scroll-mode t)
(save-place-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(use-package uniquify)
(use-package no-littering)

(provide 'decrud)
;;; decrud.el ends here
