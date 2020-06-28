;;; decrud.el -- Emacs init
;;; Commentary:
;;; Code:

(setq auto-save-default nil
      custom-file (concat user-emacs-directory "/var/custom-file.el")
      inhibit-startup-screen 1
      initial-major-mode 'org-mode
      initial-scratch-message nil
      make-backup-files nil)

(fset #'yes-or-no-p #'y-or-n-p)

(column-number-mode t)
(save-place-mode t)

(require 'uniquify)
(use-package no-littering)

(provide 'decrud)
;;; decrud.el ends here
