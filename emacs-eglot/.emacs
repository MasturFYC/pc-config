;; -*- lexical-binding: t; -*-

;; (add-to-list 'default-frame-alist
;;                '(background-color . "cornsilk3"))
(set-background-color "cdcdc1")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(faff))
 '(custom-safe-themes
   '("5c1cb093e45723623df244b11caf97592d83946a4c379637756f0dfc68621c63" default))
 '(fringe-mode 15 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(svelte-mode company-web company eglot tsc prettier coffee-mode emmet-mode yasnippet typescript-mode sass-mode rust-mode pug-mode melpa-upstream-visit lsp-grammarly go-mode gnu-elpa bash-completion ac-html ac-etags))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package)
(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))
;; (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (add-to-list 'lsp-language-id-configuration '(".*\\.svelte$" . "svelte"))
(package-initialize)

(add-to-list 'load-path "~/emac-mode/svelte-mode")
 (require 'svelte-mode)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
           '(svelte-mode . ("svelteserver" "--stdio"))))
(add-to-list 'project-vc-extra-root-markers "tsconfig.json")

(setq x-select-enable-clipboard t)
(setq debug-on-error t)
(add-hook 'after-init-hook 'global-company-mode)
;; (set-frame-parameter nil 'alpha-background  80)
;; (add-to-list 'default-frame-alist '(alpha-background . 90))
;; (add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight regular :height 105 :width normal)))))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) ; if set to true can cause a performance hit
