# Set up the prompt

export ZSH="/usr/local/zsh"

ZSH_THEME="clean"
ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

[ -f /usr/local/zsh/lib/completion.zsh ] && source /usr/local/zsh/lib/completion.zsh
