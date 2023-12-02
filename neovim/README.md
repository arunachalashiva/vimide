# Settings for neovim-0.10.0

## neovim
### Install neovim
```
wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
```
### Install vim-plug plugin manager
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
## LSP
### Python
```
pip3 install autopep8 yapf black
pip3 install 'python-lsp-server[all]'
```

### Clang
```
pip3 install compiledb
sudo apt-get install clangd
```

### Java
```
mkdir -p ${HOME}/data/jdtls
mkdir -p ${HOME}/data/workspace
mkdir -p ${HOME}/data/gradle

# Download jdt.ls
curl -sL https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.30.0/jdt-language-server-1.30.0-202311301503.tar.gz | tar xvz -C ${HOME}/data/jdtls/

# Download google-java-format
wget https://github.com/google/google-java-format/releases/download/google-java-format-1.6/google-java-format-1.6-all-deps.jar -P ${HOME}/data/

# Download lombok
wget https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.26/lombok-1.18.26.jar -P ${HOME}/data/
```
Copy **jdt** file to some directory that is under $PATH
### Go
```
go get golang.org/x/tools/gopls@latest
```
### bash
```
npm install -g bash-language-server
```
### yaml
```
npm install -g yaml-language-server
```
