;;; init.el -- Emacs init
;;; Commentary:
;;; Code:

;; You really need to do this like this.
(setq inhibit-startup-echo-area-message "iaz")

(let ((lisp-path (concat user-emacs-directory
			 (convert-standard-filename "lisp"))))
      (add-to-list 'load-path lisp-path))

;; We do this before other package setup to minimize startup frame
;; changes.
(when (display-graphic-p)
  (require 'frame-layout)
  (require 'theme))

(require 'package-setup)
(require 'decrud)
(require 'functions)
(require 'languages)

(cond
 ((eq system-type 'gnu/linux)  (require 'linux))
 ((eq system-type 'windows-nt) (require 'windows))
 ((eq system-type 'darwin)     (require 'macos)))

(provide 'init)
;;; init.el ends here
