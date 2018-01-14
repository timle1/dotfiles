export TERM="xterm-256color" 
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
plugins=(git repo debian colorize colored-man-pages command-not-found  extract docker vagrant django pip python virtualenv tmux zsh-autosuggestions zsh-completions ssh-agent zsh-syntax-highlighting)

autoload -U compinit && compinit

# ssh-agent https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding on
# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8


# Bang! Previous Command Hotkeys
# print previous command but only the first nth arguments
# Alt+1, Alt+2 ...etc
bindkey -s '\e1' "!:0 \t"
bindkey -s '\e2' "!:0-1 \t"
bindkey -s '\e3' "!:0-2 \t"
bindkey -s '\e4' "!:0-3 \t"
bindkey -s '\e5' "!:0-4 \t"
bindkey -s '\e`' "!:0- \t"     # all but the last word

#-------- Global Alias {{{
#------------------------------------------------------
# Automatically Expanding Global Aliases (Space key to expand)
# references: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html 
globalias() {
  if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
    zle _expand_alias
    zle expand-word
  fi
  # zle self-insert
  zle magic-space
}
zle -N globalias
# bindkey "^ " globalias                 # space key to expand globalalias
bindkey "^ " magic-space            # control-space to bypass completion
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches


# http://www.zzapper.co.uk/zshtips.html
alias -g ND='*(/om[1])'           # newest directory
alias -g NF='*(.om[1])'           # newest file
#alias -g NE='2>|/dev/null'
alias -g NO='&>|/dev/null'
alias -g P='2>&1 | $PAGER'
alias -g VV='| vim -R -'
alias -g L='| less'
alias -g M='| most'
alias -g C='| wc -l'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

#}}}

# https://wiki.math.cmu.edu/iki/wiki/tips/20140625-zsh-expand-alias.html
typeset -a ealiases
ealiases=()

function ealias()
{
alias $1
ealiases+=(${1%%\=*})
}

function expand-ealias()
{
  if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
      zle _expand_alias
      zle expand-word
  fi
  # zle magic-space

  globalias
}

zle -N expand-ealias

bindkey ' ' expand-ealias #  -M viins
# bindkey '^ '   magic-space     # control-space to bypass completion  -M viins
# bindkey -M isearch " "  magic-space # normal space during searches

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
ealias ezsh="code ~/.zshrc"
ealias eomz="code ~/.oh-my-zsh"
ealias edoc="code ~/Documents"
ealias open='xdg-open '


# some more ls aliases
ealias ll='ls -alF'
ealias la='ls -A'
ealias l='ls -CF'

# lxc aliases
ealias lxcl='sudo lxc-ls -f'
ealias lxcs='sudo lxc-stop -n '
ealias lxcd='sudo lxc-destroy -n '
ealias lxca='sudo lxc-attach -n '

# tmux aliases
ealias tm='tmuxp load ~/Documents/dotfiles/session.yaml'
ealias tml='tmux ls'
ealias tma='tmux attach-session -t'
ealias tmk='tmux kill-session -t'
ealias tmka="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"

# go to aliases
ealias cdoc='cd ~/Documents'
ealias cdot='cd ~/Documents/dotfiles'
ealias cnot='cd ~/Documents/notes'
ealias ccur='cd ~/Documents/ubuntu1604vagrant'

# git aliases
ealias gch='git checkout --track $(git branch -r | fzf)'
ealias gco="git commit -am"
ealias gst="git status"


# ^Z to bring job to fg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# for tmuxp, pip3 install --user tmuxp
export DISABLE_AUTO_TITLE='true'

# https://github.com/chrisallenlane/cheat
export DEFAULT_CHEAT_DIR='$HOME/Documents/notes/cheat'
export CHEATCOLORS=true
# cheat zsh autocomplete; add to ~/.zshrc
_cmpl_cheat() {
	reply=($(cheat -l | cut -d' ' -f1))
}
compctl -K _cmpl_cheat cheat

# https://github.com/gotbletu/shownotes/blob/master/fzf-snippet.md
# fzf fuzzy search, ^F history, ^Q quit ps, ^G cd into subfolder, ^E locate edit file
fzf_history() { zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }; zle -N fzf_history; bindkey '^F' fzf_history

fzf_killps() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; zle -N fzf_killps; bindkey '^Q' fzf_killps

fzf_cd() { zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" && ls; }; zle -N fzf_cd; bindkey '^G' fzf_cd

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code'
fi

# https://github.com/gotbletu/shownotes/blob/master/fzf_locate_fzf_playonlinux.md
fzf-locate() { xdg-open "$(locate "*" | fzf -e)" ;}; zle -N fzf-locate; bindkey '^O' fzf-locate

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# location of snippets
snippets_dir=~/Documents/notes

# edit single line snippet
cfg-snippetrc() { $EDITOR ~/.snippetrc ;}

# edit multiline snippet
cfg-multisnippetrc() { $EDITOR $snippets_dir/"$(ls $snippets_dir | fzf -e -i)" ;}

#create new multiline snippet
multisnippet() { $EDITOR $snippets_dir/"$1" ;}

fzf-snippet() { 
  selected="$(cat ~/.snippetrc | sed '/^$/d' | sort -n | fzf -e -i )"
  # remove tags, leading and trailing spaces, also no newline
  echo "$selected" | sed -e s/\;\;\.\*\$// | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d '\n' | xclip -selection clipboard
}

fzf-multisnippet() { 
  # merge filename and tags into single line
  results=$(for FILE in $snippets_dir/*
  do
    getname=$(basename $FILE)
    gettags=$(head -n 1 $FILE)

    echo "$getname \t $gettags" 

  done)

  # copy content into clipboard without tags
  filename=$(echo "$(echo $results | fzf -e -i )" | cut -d' ' -f 1)
  sed 1d $snippets_dir/$filename | xclip -selection clipboard
}
# use tmux to bindkey ' fzf-snippet and " fzf-multisnippet

# disable because history search is not intuitive as fzf
# # https://github.com/gotbletu/shownotes/blob/master/zsh_vim_mode.txt
# # enable vim mode on commmand line
# bindkey -v

# # no delay entering normal mode
# # https://coderwall.com/p/h63etq
# # https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
# # 10ms for key sequences
# KEYTIMEOUT=1

# # show vim status
# # http://zshwiki.org/home/examples/zlewidgets
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# # add missing vim hotkeys
# # http://zshwiki.org/home/zle/vi-mode
# bindkey -a u undo
# bindkey -a '^T' redo
# bindkey '^?' backward-delete-char  #backspace

# # history search in vim mode
# # http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
# # ctrl+r to search history
# bindkey -M viins '^r' history-incremental-search-backward
# bindkey -M vicmd '^r' history-incremental-search-backward

killall xbindkeys ; xbindkeys

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# include mongodb bin folder
PATH_TO_MONGO="$HOME/Downloads/mongodb-linux-x86_64-ubuntu1604-3.4.9/bin"
if [ -d $PATH_TO_MONGO ] ; then
	export PATH="$HOME/Downloads/mongodb-linux-x86_64-ubuntu1604-3.4.9/bin:$PATH"
fi
