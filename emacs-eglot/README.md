# Install gopls

### setting environment (~/.bashrc)
```bash
export NPM_CONFIG_PREFIX=$HOME/.local/
export PATH="/home/$USER/go/bin:/home/$USER/.local/bin:$NPM_CONFIG_PREFIX/bin:$PATH"
```
### installation
```sh
cd $(go env GOROOT)/src
go work init . cmd
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
