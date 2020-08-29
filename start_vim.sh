#!/bin/bash

# For Java, map .m2 to avoid pulling maven packages every time.
# For golang, map GOPATH to avoid pulling go packages every time.

docker run --rm --name vimide  --network host -h vimide -it \
	-p 6419:6419 \
	-e COLUMNS="`tput cols`" \
	-e LINES="`tput lines`" \
	-v ${HOME}/go:/user/work/go \
	-v ${HOME}/.m2:/home/user/.m2 \
	-v ${HOME}:/user/work \
	vim-dev:1.0
