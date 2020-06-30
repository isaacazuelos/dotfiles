;;; package-setup.el - 
;;;
;;; Commentary:
;;;
;;; Code:

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://stable.melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; For use-package's delight
(use-package delight)

(provide 'package-setup)
