#!/bin/bash

if [[ ! -d ${HOME}/.vimide ]]; then
  mkdir -p ${HOME}/.vimide/.config/nvim
  cp -R nvim/config/* ${HOME}/.vimide/.config/nvim/
  cp zshrc ${HOME}/.vimide/.zshrc
fi
docker build -t vimide:latest .
cp vimide.sh ~/.local/bin/vimide
chmod +x ~/.local/bin/vimide
