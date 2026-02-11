#!/bin/bash

# Assumes GEMINI_API_KEY and GITHUB_TOKEN are set in env
docker run -it --rm \
  --user $(id -u):$(id -g) \
  -e HOME=/home/nvimuser \
  -e DISPLAY=$DISPLAY \
  -e GEMINI_API_KEY=$GEMINI_API_KEY \
  -e GITHUB_TOKEN=$GITHUB_TOKEN \
  -v ${HOME}/.vimide:/home/nvimuser \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v ${PWD}:/workspace \
  -w /workspace \
  vimide:latest nvim
