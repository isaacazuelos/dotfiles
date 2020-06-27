;;; frame-layout.el -- non-theme gui settings
;;; Commentary:
;;;
;;; A /lot/ of this is taken from or heavily insired by rougier's
;;; elegant-emacs.
;;;
;;; The way this appears to move the modeline doesn't work in the
;;; terminal, so I strongly suggest only requireing this then
;;; DISPLAY-GRAPHIC-P is satisfied.
;;;
;;; This expects your system to have Source Code Pro, and Fira Code
;;; for some other glyphs.
;;;
;;; Code:

(defconst fixed-width-font "Source Code Pro 11"
  "The fixed-width font used for code and text.

This should be both a face and size.")

(defconst fancy-symbols-face "Fira Code Light"
  "The font use for the symbols at the edge of a frame.

This is used for things line truncation and overflow.")

(defconst frame-padding 20
  "The amount of padding around the content.")

(defconst frame-dimensions '(80 . 24)
  "The dimensions of a new frame.")

(defun use-fancy-display-glyphs ()
  "Use FANCY-SYMBOLS-FONT for trucnation and line wrapping."
  (defface fallback (list (list t :family fancy-symbols-face
			  :inherit 'face-faded))
    "Fallback"
    :group 'frame-layout)

  (set-display-table-slot standard-display-table 'truncation
			  (make-glyph-code ?… 'fallback))
  (set-display-table-slot standard-display-table 'wrap
			  (make-glyph-code ?↩ 'fallback)))

(defun set-face (face style)
  "Reset FACE and make it inherit STYLE."
  (set-face-attribute face nil
   :foreground 'unspecified :background 'unspecified
   :family     'unspecified :slant      'unspecified
   :weight     'unspecified :height     'unspecified
   :underline  'unspecified :overline   'unspecified
   :box        'unspecified :inherit    style))
  
(defun enable-header-modeline ()
  "Set the header to show the modeline."
  ;; Turn on the header modeline
  (setq-default header-line-format mode-line-format)
  ;; Make it bold
  (set-face 'header-line 'face-strong)
  ;; Give it an underline
  (set-face-attribute
   'header-line nil
   :underline (face-foreground 'default)))

(defun hide-bottom-modeline ()
  "Hide the mode line by making it empty and 'face-background' coloured."
  
  (setq-default mode-line-format '(""))
  (set-face-attribute
   'mode-line nil
   :height 10
   :underline (face-foreground 'default)
   :overline nil
   :box nil
   :foreground (face-background 'default)
   :background (face-background 'default)))

(defun set-up-frame-padding ()
  "Add some padding to the edge of frames to make things pretty."
  (fringe-mode 0)
  (setq default-frame-alist
	(append (list (cons 'width  (car frame-dimensions))
		      (cons 'height (cdr frame-dimensions))
		      '(virticle-scroll-bars nil)
		      (cons 'internal-border-width frame-padding)))))

;; Now we activate the frame changes we defined above.
;;
;; The order of these is to minimize frame size changes during a cold
;; launch.

(set-face-font 'default fixed-width-font)
(set-up-frame-padding)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(enable-header-modeline)
(hide-bottom-modeline)
(set-up-frame-padding)
(use-fancy-display-glyphs)

(set-default 'cursor-type '(bar . 1))

(setq pop-up-windows nil
      window-divider-default-right-width 2
      window-divider-default-places 'right-only
      visible-bell t
      icon-title-format ""
      ring-bell-function 'ignore
      x-underline-at-descent-line t)

(window-divider-mode)
(show-paren-mode t)
(blink-cursor-mode -1)
(pixel-scroll-mode t)
(tooltip-mode -1)

(provide 'frame-layout)
;;; frame-layout.el ends here
