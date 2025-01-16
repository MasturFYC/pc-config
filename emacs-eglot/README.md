# Install gopls

### setting environment (~/.bashrc)
```bash
cd $(go env GOROOT)/src
go work init . cmd
```
# Create an empty go.mod file, only for tracking requirements.
cd $(mktemp -d)
go mod init gopls-unstable

# Use 'go get' to add requirements and to ensure they work together.
go get -d golang.org/x/tools/gopls@master golang.org/x/tools@master

go install golang.org/x/tools/gopls
```
### Working on the Go source distribution
```
cd $(go env GOROOT)/src
go work init . cmd
```
