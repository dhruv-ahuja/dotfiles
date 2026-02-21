# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#fpath+=$HOME/.zsh/pure
# Path to your oh-my-zsh installation.
export ZSH="/Users/dhruv/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#autoload -U promptinit; promptinit
#prompt pure

# ZSH_THEME="robbyrussell"
ZSH_THEME="jovial"
# ZSH_THEME="common"

#source /usr/share/doc/fzf/examples/key-bindings.zsh

plugins=(
  zsh-history-enquirer
  git
  autojump
  urltools
  bgnotify
  zsh-autosuggestions
  zsh-syntax-highlighting
  jovial
  copyfile
)

source $ZSH/oh-my-zsh.sh

# User configuration

mk() 
{
	touch $1
	code $1
}

# if ! pgrep -x "postgres" >/dev/null; then
#     sudo pg_ctlcluster 12 main start
#     echo "postgres service started using: sudo pg_ctlcluster 12 main start"
# fi


 #Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH":~/.emacs.d/bin

# export PATH="$HOME/coding/python/yASD/app:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=true
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

. "$HOME/.local/bin/env"

export GOBIN="/Users/dhruv/go/bin"

# devops
alias k="kubectl"
alias sr="ssh racknerd" 

alias ch="defaultbrowser chrome"
alias sf="defaultbrowser safari"

# git
alias gp="git pull"
alias gpr="git pull --rebase"
alias gc="git checkout"
alias gcb="git checkout -b"
# alias gpf="git push --force"
alias gs="git stash"

alias uvr="uv run"
alias uvp="uvr python"

# ── Completions (cached in ~/.zfunc — regenerate via bootstrap.sh) ────────────
# kubectl — also wires up the `k` alias
if command -v kubectl &>/dev/null; then
  [[ ! -f ~/.zfunc/_kubectl ]] && kubectl completion zsh > ~/.zfunc/_kubectl
  compdef k=kubectl
fi

# uv (Python package manager)
if command -v uv &>/dev/null; then
  [[ ! -f ~/.zfunc/_uv ]] && uv generate-shell-completion zsh > ~/.zfunc/_uv
fi

# git — provided by Oh My Zsh git plugin (already active)

# ── fpath + compinit (must come after fpath additions above) ──────────────────
fpath+=~/.zfunc; autoload -Uz compinit; compinit

# Set fixed SSH agent socket and add keys from macOS Keychain to the agent
export SSH_AUTH_SOCK="$HOME/.ssh/ssh-auth-sock"
ssh-add -A 2>/dev/null || true
