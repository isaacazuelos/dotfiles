;;; init.el -- Emacs init
;;; Commentary:
;;; Code:

(let ((lisp-path (concat user-emacs-directory
			 (convert-standard-filename "lisp"))))
      (add-to-list 'load-path lisp-path))

;; We do this one early so there's less of a delay during cold
;; launches.
(when (display-graphic-p)
  (require 'frame-layout))

(require 'package-setup)

(require 'decrud)
(require 'functions)
(require 'languages)

(cond
 ((eq system-type 'gnu/linux)  (require 'linux))
 ((eq system-type 'windows-nt) (require 'windows)))

(provide 'init)
;;; init.el ends here
