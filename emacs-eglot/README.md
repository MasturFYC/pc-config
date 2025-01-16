# Install gopls

### setting environment (~/.bashrc)
```bash
export NPM_CONFIG_PREFIX=$HOME/.local/
export PATH="/home/$USER/go/bin:/home/$USER/.local/bin:$NPM_CONFIG_PREFIX/bin:$PATH"
```
### installation
```sh
### Create an empty go.mod file, only for tracking requirements.
cd $(mktemp -d)
go mod init gopls-unstable

### Use 'go get' to add requirements and to ensure they work together.
go get -d golang.org/x/tools/gopls@master golang.org/x/tools@master

go install golang.org/x/tools/gopls
```

### Working on the Go source distribution
```sh
cd $(go env GOROOT)/src
go work init . cmd
```

### Configuring Eglot (~/.emacs)
```emacs
(require 'project)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)
```

### Loading Eglot in (~/.emacs)
```emacs
;; Optional: load other packages before eglot to enable eglot integrations.
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
(add-hook 'go-mode-hook #'eglot-format-buffer-before-save)
```

### Configuring gopls via Eglot (~/.dir-locals.el)
```emacs
((nil (eglot-workspace-configuration . ((gopls . ((staticcheck . t)
						  (matcher . "CaseSensitive")))))))
```

### Organizing imports with Eglot
```emacs
(add-hook 'before-save-hook
    (lambda ()
        (call-interactively 'eglot-code-action-organize-imports))
    nil t)
```

### formating indent
```emacs
(add-hook 'go-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'gofmt-before-save)
	    (setq-default)
	    (setq tab-width 4)
	    (setq standard-indent 4)
	    (setq indent-tabs-mode nil)))
```
