;;; init.el -- Emacs init file
;;;
;;; Commentary:
;;;
;;; Code:

(require 'package)

(setq package-archives
      '(("gnu"          . "http://elpa.gnu.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")
        ("org"          . "http://orgmode.org/elpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-defer  t
      use-package-always-ensure t)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(setq custom-file (concat user-emacs-directory "/var/custom-file.el"))
(setq mode-line-percent-position nil)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(pixel-scroll-mode t)
(delete-selection-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode t)
(electric-pair-mode)

(use-package exec-path-from-shell
  :ensure t
  :init (exec-path-from-shell-initialize))

(use-package no-littering
  :init
  (require 'no-littering))

(use-package delight
  :init
  (delight 'eldoc-mode nil "ElDoc"))

(use-package counsel
  :delight
  :init
  (use-package counsel-projectile
    :config
    (setq projectile-project-search-path
	  '("~/src/" "~/projects")))
  :config
  (setq ivy-use-virtual-buffers t
	ivy-count-format "(%d/%d) ")
  (delight 'ivy-mode nil "ivy")
  (add-hook 'after-init-hook #'ivy-mode)
  (add-hook 'after-init-hook #'counsel-mode))

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

(when (display-graphic-p)
  (when (iaz:font-exists-p "Fira Code")
    (iaz:set-font "Fira Code" 13)))

(use-package nord-theme
  :init
  (load-theme 'nord t))

;; Prog mode

(add-hook 'prog-mode-hook #'linum-mode)

(use-package flycheck
  :delight
  :hook (prog-mode . flycheck-mode))

(use-package company
  :delight
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t))

(use-package lsp-mode
  :delight
  :commands lsp
  :config
  (require 'lsp-clients)
  (setq lsp-enable-snippet nil))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Rust mode

(use-package toml-mode)

(use-package rust-mode
  :hook (rust-mode . lsp))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Ledger

(use-package ledger-mode)
