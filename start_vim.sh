#!/bin/bash

# For Java, map .m2 to avoid pulling maven packages every time.
# For golang, map GOPATH to avoid pulling go packages every time.
docker rm vimide > /dev/null 2>&1

docker run --name vimide  --network host -h vimide -it \
	-e COLUMNS="`tput cols`" \
	-e LINES="`tput lines`" \
	-v ${HOME}/go:/root/go \
	-v ${HOME}/.m2:/root/.m2 \
	-v ${HOME}:/root/work \
	vim-dev:1.0
