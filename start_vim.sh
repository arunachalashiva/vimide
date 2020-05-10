#!/bin/bash
docker run -h vimide -it -v ${HOME}/.m2:/root/.m2 -v ${HOME}/work:/root/work -p 8091:8090 vim-dev:1.0
