;;; layout.el -- Load the theme and theme-adjacent changes
;;; Commentary:
;;;
;;; Not everything I'd want to configure as part of the theme can
;;; really be called the theme, so other parts end up here.
;;;
;;; The boring.el file should be mostly independant of this file.
;;;
;;; Code:

(defconst fixed-width-font "Source Code Pro 11")
(defconst frame-padding 20)
(defconst frame-dimensions '(84 . 54))

(add-to-list 'custom-theme-load-path
	     (concat user-emacs-directory
		     (convert-standard-filename "themes")))

(defun set-up-frame-padding ()
 "Add some padding to the edge of frames to make things pretty."
  (setq default-frame-alist
	(append `((width                  . ,(car frame-dimensions))
		  (height                 . ,(cdr frame-dimensions))
		  (vertical-scroll-bars   . nil)
                  (internal-border-width  . ,frame-padding)))))


;; Mode Line Functions
;;
;; Instead of Emacs calling FORMAT-MODE-LINE, we call it a few times
;; recursively to allow us to right-align text in the lines. The left
;; and right parts are in the LINE-FORMAT-LEFT and LINE-FORMAT-RIGHT
;; constants below.

(defconst line-format-left 
  '((:eval (propertize (buffer-name) 'face '(:weight bold)))
    " "
    (:eval (if (and buffer-file-name (buffer-modified-p))
               (propertize "(modified)" 'face '(:inherit shadow)))))
  "The left-aligned part of the mode line")

(defconst line-format-right
  '(" "
    "%e"
    (:eval (propertize (format-mode-line mode-name t) 'face '(:inherit shadow)))
    "%4l:%2c")
  "The right-aligned pat of the mode line")

(defun mode-line-render ()
  "This function is called ever time the mode line is updated."
  (simple-mode-line-render
   (format-mode-line line-format-left t)
   (format-mode-line line-format-right t)))

;; From https://emacs.stackexchange.com/questions/5529
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

;; Load the theme before we move the mode line, since we change the
;; theme a little to hide the mode line.

;; Now we can set the header and mode lines, and override the theme's
;; font sizes as a way to 'hide' the mode line om a theme-inspired way.
(load-theme 'boring t)

(set-face-attribute 'header-line nil :height 110)
(setq-default header-line-format '(:eval (mode-line-render)))
(set-face-attribute 'mode-line nil :height 10)
(setq-default mode-line-format '(""))

;; Other layout changes with settings and modes
(set-up-frame-padding)
(setq x-underline-at-descent-line t)
(blink-cursor-mode -1)
(menu-bar-mode -1)
(pixel-scroll-mode 1)
(scroll-bar-mode -1)
(set-default 'cursor-type '(bar . 2))
(set-face-font 'default fixed-width-font)
(setq pop-up-windows nil)
(setq visible-bell t ring-bell-function #'ignore)
(show-paren-mode 1)
(tool-bar-mode -1)
(tooltip-mode -1)
(window-divider-mode)

(provide 'layout)
;;; layout.el ends here
