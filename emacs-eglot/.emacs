(set-background-color "#cdcdc1")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(custom-enabled-themes '(faff))
 '(custom-safe-themes
   '("5c1cb093e45723623df244b11caf97592d83946a4c379637756f0dfc68621c63" "06de088e81494d28a8b4525c095a525e72fe146010e9e330389ed55ffbbe5956" "5e5cc9337ca0eee5c32822c69212efa44c42a4dabe3ab11cb2807825178b46f5" "59e41dff1091d919d72b1afd984a9f7f4d855df82686c1370002e82ebbe27b7d" "86fb83c7228092ff727a07b59bb2e61024880193cc559378a774418c6b53be21" default))
 '(custom-theme-directory "~/.emacs.d/themes")
 '(fringe-mode 10 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(yasnippet go-mode company-shell json-mode rust-mode lsp-mode company coffee-mode sass-mode typescript-mode pug-mode))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(set-frame-parameter nil 'alpha-background  80)
(add-to-list 'default-frame-alist '(alpha-background . 90))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight regular :height 105 :width normal)))))

(require 'package)
;; (add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(add-to-list 'load-path "/home/fyc/.emac-mode/svelte-mode")
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

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) ; if set to true can cause a performance hit

;; GOLANG
(require 'project)
(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(require 'company)
(require 'yasnippet)
(require 'go-mode)
(require 'eglot)
(add-hook 'go-mode-hook 'eglot-ensure)

;; Optional: install eglot-format-buffer as a save hook.
;; The depth of -10 places this before eglot's willSave notification,
;; so that that notification reports the actual contents that will be saved.
(defun eglot-format-buffer-before-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

;; format indent
(add-hook 'go-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'gofmt-before-save)
	    (setq-default)
	    (setq tab-width 4)
	    (setq standard-indent 4)
	    (setq indent-tabs-mode nil)))
