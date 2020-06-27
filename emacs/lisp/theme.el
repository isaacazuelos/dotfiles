;;; theme.el -- Load the theme and customizations
;;; Commentary:
;;; Code:

(add-to-list 'custom-theme-load-path
	     (concat user-emacs-directory
		     (convert-standard-filename "themes")))
(load-theme 'actuator t)

(provide 'theme)
;;; theme.el ends here
