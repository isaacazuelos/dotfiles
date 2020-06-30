;;; boring-theme.el -- a theme that's boring
;;;
;;; Commentary:
;;;
;;; While this theme can be used alone, some of the changes it makes
;;; are designed to be used with the settings changed in the layout.el
;;; file.
;;;
;;; Code:

(deftheme boring "A boring theme")

;;; There's a set of colours, which are then mapped onto semantic
;;; categoires, which are then applied to specific faces.
(let (;; Accent Colours
      (blue   "#5586A9")
      (green  "#549268")
      (yellow "#DDB438")
      (orange "#CE763B")
      (red    "#C94862")
      (purple "#B16FC3")

      ;; Base Colours
      (foreground "#333333")
      (midground  "#999999")
      (background "#F8F8F8")

      ;; Status Colours
      (go     "#85F86E")
      (slow   "#EEF831")
      (stop   "#FF325B")
      (select "#a2dcf1")
      (shade  "#cccccc"))

  (let (;; Typefaces
  (fixed-pitch-face "Source Code Pro")
  (variable-pitch-face "Source Sand Pro")

  ;; syntactic elements
  (comment midground)

  ;; language syntax is blue
  (syntax blue)

  ;; the bulk of code is identifiers, so it's foreground
  (function  foreground)
  (var       foreground)

  ;; things to encourage are green
  (docstring green)
  (type      green)

  ;; things with fixed values are purple
  (constant  purple)
  (literal   purple))
    (custom-theme-set-faces
     `boring
     `(default                         ((t (:background ,background :foreground ,foreground))))
     `(fixed-pitch                     ((t (:family     ,fixed-pitch-face))))
     `(variable-pitch                  ((t (:family     ,variable-pitch-face))))
     `(shadow                          ((t (:foreground ,shade))))
     `(cursor                          ((t (:background ,stop))))
     `(region                          ((t (:background ,select))))

     ;; font lock
     `(font-lock-builtin-face       ((t (:foreground ,syntax      :inherit fixed-pitch))))
     `(font-lock-comment-face       ((t (:foreground ,comment     :inherit fixed-pitch))))
     `(font-lock-constant-face      ((t (:foreground ,constant    :inherit fixed-pitch))))
     `(font-lock-doc-face           ((t (:foreground ,docstring   :inherit fixed-pitch))))
     `(font-lock-function-name-face ((t (:foreground ,function    :inherit fixed-pitch))))
     `(font-lock-keyword-face       ((t (:foreground ,syntax      :inherit fixed-pitch))))
     `(font-lock-preprocessor-face  ((t (:foreground ,syntax      :inherit fixed-pitch))))
     `(font-lock-string-face        ((t (:foreground ,literal     :inherit fixed-pitch))))
     `(font-lock-type-face          ((t (:foreground ,type        :inherit fixed-pitch))))
     `(font-lock-variable-name-face ((t (:foreground ,var         :inherit fixed-pitch))))

     ;; mode line
     `(mode-line          ((t (:foreground  ,foreground
                               :background  ,background
                               :underline   (:color ,foreground)
                               :inherit     default))))
     `(mode-line-inactive ((t (:foreground  ,midground
                               :underline   (:color ,midground)
                               :inherit     mode-line))))
     `(header-line        ((t (:underline   (:color ,foreground)
                               :foreground  ,foreground
                               :background  ,background
                               :inherit     mode-line))))
     
     ;; packages
     `(fringe             ((t (:background  ,background))))

     `(flycheck-warning   ((t (:underline   (:color ,slow)))))
     `(flycheck-error     ((t (:underline   (:color ,stop)))))
     `(linum              ((t (:background  ,background
                               :foreground  ,shade))))
     
     ;; rainbows!
     `(rainbow-delimiters-depth-1-face ((t (:foreground  ,blue))))
     `(rainbow-delimiters-depth-2-face ((t (:foreground  ,green))))
     `(rainbow-delimiters-depth-3-face ((t (:foreground  ,yellow))))
     `(rainbow-delimiters-depth-4-face ((t (:foreground  ,red))))
     `(rainbow-delimiters-depth-5-face ((t (:foreground  ,purple))))
     `(rainbow-delimiters-depth-6-face ((t (:foreground  ,blue))))
     `(rainbow-delimiters-depth-7-face ((t (:foreground  ,green))))
     `(rainbow-delimiters-depth-8-face ((t (:foreground  ,yellow))))
     `(rainbow-delimiters-depth-9-face ((t (:foreground  ,red)))))))

(provide-theme 'boring)
;; boring-theme.el ends here
