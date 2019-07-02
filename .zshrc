# if [ $TERM = "linux" ]; then
#     export TERM="fbterm"
#     fbterm
# fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs disk_usage time)
VIRTUAL_ENV_DISABLE_PROMPT=1
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=true
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
# POWERLEVEL9K_HOME_FOLDER_ABBREVIATION="%F{magenta} $(print_icon 'HOME_ICON') %F{black}"
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER="…"
POWERLEVEL9K_VIRTUALENV_BACKGROUND='cyan'

DEFAULT_USER="gordon"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
COMPLETION_WAITING_DOTS="true"

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

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*) Custom plugins may be added to
# ~/.oh-my-zsh/custom/plugins/ Example format: plugins=(rails git textmate ruby
# lighthouse) Add wisely, as too many plugins slow down shell startup.
plugins=(git git-extras python virtualenvwrapper tmux pip zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions if [[ -n $SSH_CONNECTION ]];
# then export EDITOR='vim' else export EDITOR='mvim' fi

# Compilation flags export ARCHFLAGS="-arch x86_64"

# ssh export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins,
# and themes. Aliases can be placed here, though oh-my-zsh users are encouraged
# to define aliases within the ZSH_CUSTOM folder.  For a full list of active
# aliases, run `alias`.
#
# Example aliases alias zshconfig="mate ~/.zshrc" alias ohmyzsh="mate
# ~/.oh-my-zsh"

source /usr/bin/virtualenvwrapper.sh

alias startx="startx & vlock"
alias chromium="chromium --touch-devices=9" export
EDITOR='nvim'
alias vi='nvim'

alias ip="ip --color"

alias icat="kitty +kitten icat"

export DOTFILES_PRIVATE="$HOME/.dotfiles"

setopt NO_SHAREHISTORY
unset GREP_OPTIONS

man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

function w() {
    cd "/home/gordon/Documents/dev/$1"
}

export QT_SELECT=5

export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="red"
export TLDR_COLOR_PARAMETER="white"

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python

function p {
    local SUFFIX="$@"
    if [[ "$VIRTUAL_ENV" != "" ]]
    then
      local PREFIX="$VIRTUAL_ENV"/bin
      COMMANDS=("python")
    else
      local PREFIX=/usr/bin
      COMMANDS=("python3.7" "python")
    fi

    if [[ "$#" -eq 0 ]]; then
        SUFFIX=""
        local COMMANDS=("python3.7 -m ptpython"
                        "python3.7 -m ipython"
                        "python -m ptpython"
                        "python -m ipython"
                        "python")
    fi

    for i in "${COMMANDS[@]}"
    do
       $PREFIX'/'$i $SUFFIX;
       [ "$?" -eq 0 ] && return 0
    done

}

[ -f ~/.secrets ] && source ~/.secrets
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
