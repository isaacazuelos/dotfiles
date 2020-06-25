;;; functions.el -- custom functions
;;; Commentary:
;;; Code:

(defun iaz:open-init ()
  "Open user init file."
  (interactive)
  (find-file user-init-file))

(defun iaz:font-exists-p (font)
  "Return non-nil if FONT is loaded."
  (member font (font-family-list)))

(defun iaz:set-font (name size)
  "Add the font named NAME at SIZE to the DEFAULT-FRAME-ALIST."
  (let ((font-string (format "%s-%d" name size)))
    ;; set the font for /this/ frame
    (set-frame-font font-string nil t)
    ;; we also want to set the font for all future frames
    (add-to-list 'default-frame-alist (cons 'font font-string))))

(provide 'functions)
;;; functions.el ends here
