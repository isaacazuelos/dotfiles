;;; init.el -- Emacs init
;;; Commentary:
;;; Code:

(let ((lisp-path (concat user-emacs-directory
			 (convert-standard-filename "lisp"))))
      (add-to-list 'load-path lisp-path))

(require 'package-setup)
(require 'decrud)
(require 'functions)
(require 'languages)

(cond
 ((eq system-type 'gnu/linux)  (require 'linux))
 ((eq system-type 'windows-nt) (require 'windows)))

(provide 'init)
;;; init.el ends here
