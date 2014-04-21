;;; emacs --- aineko's way

; package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))


; zenburn-theme
;; (install-if-needed 'zenburn-theme)
;; (load-theme 'zenburn t)

; solarized-theme
(install-if-needed 'solarized-theme)
;; (load-theme 'solarized-light t)
;; (load-theme 'solarized-dark t)

(defvar current-theme 'default)

(defun my-load-theme (theme)
  (set 'current-theme theme)
  (load-theme theme t))

(defun switch-theme ()
  (interactive)
  (if (eq current-theme 'solarized-light)
      (my-load-theme 'solarized-dark)
    (my-load-theme 'solarized-light)))

(switch-theme)


; linum
(install-if-needed 'linum)
(require 'linum)
(global-linum-mode 1)


; fill-column-indicator
(install-if-needed 'fill-column-indicator)
(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)


; whitespace
(install-if-needed 'whitespace)
(require 'whitespace)
(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)


; flyspell
(require 'flyspell)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)


; magit
(install-if-needed 'magit)
(require 'magit)
(global-set-key "\C-xg" 'magit-status)


; auto-complete
(install-if-needed 'auto-complete)
(require 'auto-complete)
(setq
 as-auto-start 2
 ac-override-local-map t
 ac-candidate-limit 20)
(ac-flyspell-workaround)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)


; autopair
(install-if-needed 'autopair)
(require 'autopair)


; yasnippet
(install-if-needed 'yasnippet)
(require 'yasnippet)
(yas-global-mode 1)


; semantic
(semantic-mode 1)


; python-mode
(install-if-needed 'python-mode)
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)
(setq python-indent-offset 2)
(add-hook 'python-mode-hook 'autopair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "RET") 'newline)))

; jedi
;; pip install --user jedi
;; pip install --user epc
;; (setq jedi:server-command
;;       '("python2" "~/.emacs.d/elpa/jedi-0.1.2/jediepcserver.py"))
(install-if-needed 'jedi)
(require 'jedi)

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goo-definition)))

(setq jedi:complete-on-dot t)


; flycheck
;; pip install --user pylint
(install-if-needed 'flycheck)
(require 'flycheck)
(global-flycheck-mode t)

(defun my-emacs-lisp-hook ()
  (setq flycheck-emacs-lisp-load-path load-path))
(add-hook 'emacs-lisp-mode-hook #'my-emacs-lisp-hook)


; smex
(install-if-needed 'smex)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)


; expand-region
(install-if-needed 'expand-region)
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)


; framemove
(install-if-needed 'framemove)
(require 'framemove)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)


; ecb
(install-if-needed 'ecb)
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq ecb-layout-name "left9")
(setq ecb-options-version "2.40")


; Visual tweaks
(setq-default indent-tabs-mode nil)
(setq-default fill-column 80)
(menu-bar-mode 0)
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-frame-size (selected-frame) 100 80))
(setq inhibit-startup-screen t)
(show-paren-mode t)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(ido-mode t)

; workaround to fix the previous-line bug in Emacs 24.3
;; (defun go-back ()
;;   (interactive)
;;   (forward-line -1))

;; (global-set-key [?\C-p] 'go-back)


; Load local stuff
(load "~/.emacs-local" t nil t nil)


; Custom variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-name "left9")
 '(ecb-layout-window-sizes (quote (("left9" (ecb-methods-buffer-name 0.15639810426540285 . 0.9166666666666666)))))
 '(ecb-options-version "2.40")
 '(magit-use-overlays nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
