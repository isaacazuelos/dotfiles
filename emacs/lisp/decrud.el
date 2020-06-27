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
 make-backup-files nil)

(fset 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)
(save-place-mode t)

(use-package uniquify)
(use-package no-littering)

(provide 'decrud)
;;; decrud.el ends here
