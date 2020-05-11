#!/bin/bash

# For Java, map .m2 to avoid pulling maven packages every time.
# For golang, map GOPATH to avoid pulling go packages every time.
docker rm vimide > /dev/null 2>&1
docker run --name vimide --network host -h vimide -it -v ${HOME}/.m2:/root/.m2 -v ${HOME}/work:/root/work vim-dev:1.0
