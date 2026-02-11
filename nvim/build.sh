#!/bin/bash

mkdir -p ${HOME}/.myvim

docker run -it --rm \
  -v ${HOME}/.myvim/local:/root/.local \
  nvim:latest nvim
