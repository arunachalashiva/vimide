# neovim IDE in a docker
My neovim configuration packaged in a docker and has the below programming languages installed. Docker image
also include other tools used by these plugins (like fzf, gemini, npm, oh-my-zsh).
## Languages
* java - version 1.21
* python 3.12
* c++
* go 1.24

## Tools
* gemini-cli - For codecompanion ACP.
* fzf - To search for files, git commits, tags, Rg grep
* ripgrep - To search for files, git commits, tags, Rg grep
* lazygit - Git wrapper
* oh-my-zsh - zsh terminal

## Look and feel
* Tokyo night - Default theme
* Catpuccin

## Install
Run `install.sh` to install. Assumes GEMINI_API_KEY is set in env for codecompanion. Installs the binary `vimide` in **$HOME/.local/bin** (add it to PATH).
