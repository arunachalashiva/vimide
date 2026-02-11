#!/bin/bash

# Prepare data directory
if [[ ! -d ${HOME}/.vimide ]]; then
  # create ~/.vimide for persisting config. Also home directory of docker
  mkdir -p ${HOME}/.vimide/.config/nvim
fi

# copy neovim config to home directory
cp -R nvim/config/* ${HOME}/.vimide/.config/nvim/

# copy .zshrc to home directory
cp zshrc ${HOME}/.vimide/.zshrc

# copy .gitconfig to home directory
cp ${HOME}/.gitconfig ${HOME}/.vimide/

# Build docker
docker build \
  --build-arg USERNAME=$(whoami) \
  --build-arg USER_UID=$(id -u) \
  --build-arg USER_GID=$(id -g) \
  -t vimide:latest .

# Copy Binary
cp vimide.sh ~/.local/bin/vimide
chmod +x ~/.local/bin/vimide
