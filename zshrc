# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/tenacity/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
DEFAULT_USER="tenacity"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# for zsh-syntax-highlighting
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
plugins=(git repo debian colorize colored-man-pages command-not-found compleat extract docker vagrant redis-cli postgres celery django pip python virtualenv tmux zsh-syntax-highlighting)

# ssh-agent

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

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
ealias cfgzsh="code ~/.zshrc"
ealias cfgomz="code ~/.oh-my-zsh"

# some more ls aliases
ealias ll='ls -alF'
ealias la='ls -A'
ealias l='ls -CF'
